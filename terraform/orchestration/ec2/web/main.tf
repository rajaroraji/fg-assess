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

data "terraform_remote_state" "ec2b" {
  backend = "s3"
  config = {
    bucket = "fg-access-terraform"
    region = "us-east-1"
    key    = "dev/ec2w"  
  }
}


module "ec2_instance" {
  source = "../../modules/ec2"

  sg_name                = var.web_sg_name
  sg_description         = var.web_sg_description
  vpc_id                 = data.terraform_remote_state.vpc.outputs.vpc_id
  sg_ingress_from_port   = var.web_sg_ingress_from_port
  sg_ingress_to_port     = var.web_sg_ingress_to_port
  sg_ingress_protocol    = var.web_sg_ingress_protocol
  sg_ingress_security_group_ids = data.terraform_remote_state.ec2b.outputs.security_group_id
  sg_egress_from_port    = var.web_sg_egress_from_port
  sg_egress_to_port      = var.web_sg_egress_to_port
  sg_egress_protocol     = var.web_sg_egress_protocol
  sg_egress_cidr_blocks  = var.web_sg_egress_cidr_blocks
  ami                    = var.web_ami
  instance_type          = var.web_instance_type
  subnet_id              = [tolist(data.terraform_remote_state.vpc.outputs.private_subnet_ids)[0]]
  key_name               = var.web_key_name
  instance_name          = var.web_instance_name
}
