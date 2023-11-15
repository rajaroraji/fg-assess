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

data "terraform_remote_state" "ec2" {
  backend = "s3"
  config = {
    bucket = "fg-access-terraform"
    region = "us-east-1"
    key    = "dev/ec2"  
  }
}


module "aws_rds" {
  source = "./rds-module"  # Path to your RDS module

  # Pass variables to the module
  db_name                    = var.rds_db_name
  engine                     = var.rds_engine
  engine_version             = var.rds_engine_version
  instance_class             = var.rds_instance_class
  allocated_storage          = var.rds_allocated_storage
  storage_type               = var.rds_storage_type
  db_username                = var.rds_db_username
  db_password                = var.rds_db_password
  parameter_group_name       = var.rds_parameter_group_name
  vpc_id                     = data.terraform_remote_state.vpc.outputs.vpc_id
  private_subnets            = [tolist(data.terraform_remote_state.vpc.outputs.private_subnet_ids)[1]]
  security_group_name        = var.rds_security_group_name
  security_group_description = var.rds_security_group_description
  ingress_from_port          = var.rds_ingress_from_port
  ingress_to_port            = var.rds_ingress_to_port
  ingress_protocol           = var.rds_ingress_protocol
  web_security_group_id      = data.rds_terraform_remote_state.ec2.outputs.web-sg_id
  tags                       = var.rds_tags
}
