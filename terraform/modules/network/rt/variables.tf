variable "vpc_id" {}
variable "tags" {}

variable "private_subnets" {
  type = map
}

variable "public_subnets" {
  type=map
}

variable "gateway_id" {}

variable "nat_gateway_id" {}