resource "aws_eks_node_group" "eks-ng-app" {

  cluster_name    = var.eks_cluster_name



  node_group_name = var.name

  node_role_arn   = var.role_arn

  subnet_ids      = var.subnet_ids



  scaling_config {

    desired_size = var.desired_size

    max_size     = var.max_size

    min_size     = var.min_size

  }



  lifecycle {

    ignore_changes = [scaling_config[0].desired_size]

  }





  remote_access {

    ec2_ssh_key =  var.ssh_key_name

  }



  capacity_type = "ON_DEMAND"

  disk_size = var.disk_size

  instance_types = [var.instance_type]

  labels = {

    role = var.node_group_role

  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.

  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.

}