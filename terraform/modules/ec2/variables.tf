variable "sg_name" {
  description = "Name of the security group"
  type        = string
}

variable "sg_description" {
  description = "Description of the security group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the security group and EC2 instance will be created"
  type        = string
}

variable "sg_ingress_from_port" {
  description = "Start port range for the ingress rule"
  type        = number
}

variable "sg_ingress_to_port" {
  description = "End port range for the ingress rule"
  type        = number
}

variable "sg_ingress_protocol" {
  description = "Protocol for the ingress rule"
  type        = string
}

variable "sg_ingress_cidr_blocks" {
  description = "CIDR blocks for the ingress rule"
  type        = list(string)
}

variable "sg_ingress_security_group_ids" {
  description = "List of security group IDs for the ingress rule"
  type        = list(string)
  default     = []
}

variable "sg_egress_from_port" {
  description = "Start port range for the egress rule"
  type        = number
}

variable "sg_egress_to_port" {
  description = "End port range for the egress rule"
  type        = number
}

variable "sg_egress_protocol" {
  description = "Protocol for the egress rule"
  type        = string
}

variable "sg_egress_cidr_blocks" {
  description = "CIDR blocks for the egress rule"
  type        = list(string)
}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be launched"
  type        = string
}

variable "key_name" {
  description = "Key name for the EC2 instance"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}
