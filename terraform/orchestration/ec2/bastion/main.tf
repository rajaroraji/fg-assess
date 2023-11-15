terraform {
  backend "s3" {}
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "fg-access-terraform"
    region = "us-east-1"
    key    = "dev/vpc"  
  }
}


module "ec2_instance" {
  source = "../../modules/ec2"

  sg_name                = var.bastion_sg_name
  sg_description         = var.bastion_sg_description
  vpc_id                 = data.terraform_remote_state.vpc.outputs.vpc_id
  sg_ingress_from_port   = var.bastion_sg_ingress_from_port
  sg_ingress_to_port     = var.bastion_sg_ingress_to_port
  sg_ingress_protocol    = var.bastion_sg_ingress_protocol
  sg_ingress_cidr_blocks = var.bastion_sg_ingress_cidr_blocks
  sg_egress_from_port    = var.bastion_sg_egress_from_port
  sg_egress_to_port      = var.bastion_sg_egress_to_port
  sg_egress_protocol     = var.bastion_sg_egress_protocol
  sg_egress_cidr_blocks  = var.bastion_sg_egress_cidr_blocks
  ami                    = var.bastion_ami
  instance_type          = var.bastion_instance_type
  subnet_id              = values(data.terraform_remote_state.vpc.outputs.public_subnet_ids)
  key_name               = var.bastion_key_name
  instance_name          = var.bastion_instance_name
}
