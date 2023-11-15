region = "ap-south-1"
env = "dev"
tags = {
  "managed_by": "terraform",
  "env": "dev"
}
vpc_cidr_block = "10.0.0.0/16"
subnet_cidrs = {
  "public": {"a": "10.0.10.0/24"},
  "private": {"a": "10.0.40.0/21", "b": "10.0.48.0/21"}
}

#alb
alb_name                        = "fg-alb"
alb_certificate_arn             = "arn:aws:acm:region:account-id:certificate/certificate-id"
alb_enable_deletion_protection  = false
alb_idle_timeout                = 300
alb_enable_http2                = true
alb_ingress_cidr_blocks     = ["0.0.0.0/0"]
alb_egress_cidr_blocks      = ["0.0.0.0/0"]
alb_target_group_name           = "fg-tg"
alb_target_group_port           = 8080
alb_target_group_protocol       = "HTTP"
alb_target_group_health_check   = {
  enabled             = true
  interval            = 30
  path                = "/"
  port                = "traffic-port"
  protocol            = "HTTP"
  healthy_threshold   = 3
  unhealthy_threshold = 3
  timeout             = 5
  matcher             = "200"
}
alb_forward_rule_host_header    = ["test.fortisgames.com/"]
alb_forward_rule_priority       = 1


#RDS
rds_db_name                    = "fg-mysql-db"
rds_engine                     = "mysql"
rds_engine_version             = "5.7.31"
rds_instance_class             = "db.t2.micro"
rds_allocated_storage          = 20
rds_storage_type               = "gp3"
rds_db_username                = "admin"
rds_parameter_group_name       = "default.mysql5.7"
rds_security_group_name        = "my-rds-sg"
rds_security_group_description = "RDS Security Group"
rds_ingress_from_port          = 3306
rds_ingress_to_port            = 3306
rds_ingress_protocol           = "tcp"
rds_tags                       = { Environment = "dev", Project = "fg-Project" }


#bastion-ec2

bastion_sg_name                = "bastion-sg"
bastion_sg_description         = "Security group for bastion host"
bastion_sg_ingress_from_port   = 22
bastion_sg_ingress_to_port     = 22
bastion_sg_ingress_protocol    = "tcp"
bastion_sg_ingress_cidr_blocks = ["0.0.0.0/0"]  # Be cautious with 0.0.0.0/0, restrict as needed
bastion_sg_egress_from_port    = 0
bastion_sg_egress_to_port      = 0
bastion_sg_egress_protocol     = "-1"
bastion_sg_egress_cidr_blocks  = ["0.0.0.0/0"]
bastion_ami                    = "ami-12345678"
bastion_instance_type          = "t2.micro"
bastion_key_name               = "my-bastion-key-pair"
bastion_instance_name          = "BastionHost"
