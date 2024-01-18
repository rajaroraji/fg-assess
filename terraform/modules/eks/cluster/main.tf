resource "aws_eks_cluster" "eks-cluster" {

  name     = var.cluster_name

  role_arn = var.role_arn

  version = var.eks-version

  vpc_config {

    subnet_ids = var.subnet-ids

  }
  }