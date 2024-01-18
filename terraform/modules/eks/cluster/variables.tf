variable "env" {}

variable "role_arn" {}



variable "eks-version" {

  default = 1.25

}



variable "subnet-ids" {}



variable "eks_policy_attachment_id" {

  # this is to create the dependency between policy attachment and eks cluster creation

}

variable "cluster_name" {}