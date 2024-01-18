variable "env" {}

variable "eks_cluster_name" {}

variable "name" {}

variable "role_arn" {}



variable "subnet_ids" {}



variable "desired_size" {

  default = 1

}



variable "max_size" {

  default = 6

}



variable "min_size" {

  default = 1

}



variable "ssh_key_name" {

  default = "eks-staging-key"

}



variable "disk_size" {

  default = 100

}



variable "instance_type" {

  default = "m5.xlarge"

}



variable "node_group_role" {}



variable "container_registry_attachment_id" {}

variable "cni_policy_attachment_id" {}

variable "auto_scaling_policy_attachment_id" {}

variable "worker_node_policy_attachment_id" {} 