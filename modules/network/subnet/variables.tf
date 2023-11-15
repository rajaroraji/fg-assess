variable "public_subnet_cidrs" {
  type=map
}

variable "private_subnet_cidrs" {
  type=map
}

variable "vpc_id" {
  description = "vpc id in which subnets will be created"
  type = string
}

variable "region" {}

variable "tags" {}