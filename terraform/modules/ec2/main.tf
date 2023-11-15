resource "aws_security_group" "this" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.sg_ingress_cidr_blocks
    content {
      from_port   = var.sg_ingress_from_port
      to_port     = var.sg_ingress_to_port
      protocol    = var.sg_ingress_protocol
      cidr_blocks = [ingress.value]
    }
  }

  dynamic "ingress" {
    for_each = var.sg_ingress_security_group_ids
    content {
      from_port        = var.sg_ingress_from_port
      to_port          = var.sg_ingress_to_port
      protocol         = var.sg_ingress_protocol
      security_groups  = [ingress.value]
    }
  }
}

resource "aws_instance" "example" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.this.id]

  tags = {
    Name = var.instance_name
  }
}
