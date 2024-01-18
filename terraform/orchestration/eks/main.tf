terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 0.15"
}

provider "aws" {
  region = var.region
}


module "iam_role_setup" {

  source = "../../modules/network/iam/role"

  assume_policy = jsonencode({

    Version: "2012-10-17",

    Statement: [

      {

        Effect: "Allow",

        Principal: {

          Service: "eks.amazonaws.com"

        },

        Action: "sts:AssumeRole"

      }

    ]

  })



  role_name = "EKSClusterRole-${var.env}"

}



module "eks_policy_attachment" {

  source = "../../modules/network/iam/policy_attachment"

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

  role_name = module.iam_role_setup.role_name

}



module "asg_policy" {

  source = "../../modules/network/iam/policy"

  name = "AmazonEKSAutoscalingPolicy-${var.env}"

    policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Action   = [

          "autoscaling:DescribeAutoScalingGroups",

          "autoscaling:DescribeAutoScalingInstances",

          "autoscaling:DescribeLaunchConfigurations",

          "autoscaling:DescribeTags",

          "autoscaling:SetDesiredCapacity",

          "autoscaling:TerminateInstanceInAutoScalingGroup",

          "ec2:DescribeLaunchTemplateVersions"

        ]

        Effect   = "Allow"

        Resource = "*"

      },

    ]

  })

}



module "node_role" {

  source = "../../modules/network/iam/role"

  assume_policy = jsonencode({

    Statement = [{

      Action = "sts:AssumeRole"

      Effect = "Allow"

      Principal = {

        Service = "ec2.amazonaws.com"

      }

    }]

    Version = "2012-10-17"

  })

  role_name = "eks-nodeInstanceRole-${var.env}"

}







module "AmazonEKSWorkerNodePolicy" {

  source = "../../modules/network/iam/policy_attachment"

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

  role_name       = module.node_role.role_name

}



module "AmazonEKS_CNI_Policy" {

  source = "../../modules/network/iam/policy_attachment"

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

  role_name = module.node_role.role_name

}



module "AmazonEC2ContainerRegistryReadOnly" {

  source = "../../modules/network/iam/policy_attachment"

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

  role_name  = module.node_role.role_name

}



module "AmazonEKSAutoscalingPolicy" {

  source = "../../modules/network/iam/policy_attachment"

  policy_arn = module.asg_policy.policy_arn

  role_name  = module.node_role.role_name

}



data "terraform_remote_state" "vpc" {

  backend = "s3"

  config = {

    bucket = "dehaat-terraform"

    key    = "${var.env}/vpc"

    region = "ap-south-1"

  }

}





module "cluster" {

  source = "../../modules/eks/cluster"

  env = var.env

  eks-version = var.eks_version

  role_arn = module.iam_role_setup.role_arn

  subnet-ids = values(data.terraform_remote_state.vpc.outputs.private_subnets)

  eks_policy_attachment_id = module.eks_policy_attachment.policy_attachment_id

  cluster_name = "eks-${var.env}"

}





module "default_node_group" {

  source = "../../modules/eks/nodes"

  env = var.env

  node_group_role = "management"

  name = "eks-${var.env}-default"

  eks_cluster_name = module.cluster.name

  role_arn = module.node_role.role_arn

  subnet_ids      = values(data.terraform_remote_state.vpc.outputs.private_subnets)

  desired_size = 1

  max_size = var.default_eks_node_group_max_size

  min_size = 1

  ssh_key_name = var.eks_ssh_key

  disk_size = var.default_eks_node_group_disk_size

  instance_type = var.default_eks_node_group_instance_type

  container_registry_attachment_id = module.AmazonEC2ContainerRegistryReadOnly.policy_attachment_id

  cni_policy_attachment_id = module.AmazonEKS_CNI_Policy.policy_attachment_id

  auto_scaling_policy_attachment_id = module.AmazonEKSAutoscalingPolicy.policy_attachment_id

  worker_node_policy_attachment_id = module.AmazonEKSWorkerNodePolicy.policy_attachment_id

}