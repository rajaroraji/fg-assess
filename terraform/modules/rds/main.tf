resource "aws_db_instance" "default" {
  identifier          = var.db_name
  engine              = var.engine
  engine_version      = var.engine_version
  instance_class      = var.instance_class
  allocated_storage   = var.allocated_storage
  storage_type        = var.storage_type
  username            = var.db_username
  password            = var.db_password
  parameter_group_name= var.parameter_group_name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot = true
  multi_az            = true
  db_subnet_group_name = aws_db_subnet_group.rds_sg.name
  license_model = "license-included" 
}


resource "aws_security_group" "rds_sg" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.ingress_from_port
    to_port         = var.ingress_to_port
    protocol        = var.ingress_protocol
    security_groups = [var.web_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}


resource "aws_db_subnet_group" "rds_sg" {
    name       = "rds-subnetgroup"
    subnet_ids = var.private_subnets

    tags = {
        Name = "casestudy subnet group"
    }
}
