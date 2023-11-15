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

data "terraform_remote_state" "ec2w" {
  backend = "s3"
  config = {
    bucket = "fg-access-terraform"
    region = "us-east-1"
    key    = "dev/ec2"  
  }
}


module "aws_alb_setup" {
  source = "../../modules/alb" 
  name                        = var.alb_name
  subnets                     = values(data.terraform_remote_state.vpc.outputs.public_subnet_ids)
  vpc_id                      = data.terraform_remote_state.vpc.outputs.vpc_id
  certificate_arn             = var.alb_certificate_arn
  enable_deletion_protection  = var.alb_enable_deletion_protection
  idle_timeout                = var.alb_idle_timeout
  enable_http2                = var.alb_enable_http2
  alb_ingress_cidr_blocks     = var.alb_ingress_cidr_blocks
  alb_egress_cidr_blocks      = var.alb_egress_cidr_blocks
  target_group_name           = var.alb_target_group_name
  target_group_port           = var.alb_target_group_port
  target_group_protocol       = var.alb_target_group_protocol
  target_group_health_check   = var.alb_target_group_health_check
  instance_id                 = data.alb_terraform_remote_state.ec2.outputs.instance_id
  forward_rule_host_header    = var.alb_forward_rule_host_header
  forward_rule_priority       = var.alb_forward_rule_priority
}

