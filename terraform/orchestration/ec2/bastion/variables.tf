variable "bastion_sg_name" {}

variable "bastion_sg_description" {}


variable "bastion_sg_ingress_from_port" {}

variable "bastion_sg_ingress_to_port" {}

variable "bastion_sg_ingress_protocol" {}

variable "bastion_sg_ingress_cidr_blocks" {}

variable "bastion_sg_egress_from_port" {}

variable "bastion_sg_egress_to_port" {}

variable "bastion_sg_egress_protocol" {}

variable "bastion_sg_egress_cidr_blocks" {}

variable "bastion_ami" {}

variable "bastion_instance_type" {}


variable "bastion_key_name" {}

variable "bastion_instance_name" {}
