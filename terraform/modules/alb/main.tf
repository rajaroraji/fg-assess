
# Security Group for ALB

resource "aws_security_group" "alb_sg" {
  name        = "${var.name}-sg"
  description = "Security group for ${var.name}"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.alb_ingress_cidr_blocks
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.alb_ingress_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.alb_egress_cidr_blocks
  }

  tags = {
    Name = "${var.name}-sg"
  }
}

# ALB Resource

resource "aws_lb" "alb" {
  name                       = var.name
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = var.subnets
  security_groups            = [aws_security_group.alb_sg.id]
  enable_deletion_protection = var.enable_deletion_protection
  enable_http2               = var.enable_http2
  idle_timeout               = var.idle_timeout
}

# HTTP Listener

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      protocol    = "HTTPS"
      port        = "443"
      status_code = "HTTP_301"
    }
  }
}

# HTTPS Listener

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "OK"
    }
  }
}

# Target Group Resource

resource "aws_lb_target_group" "tg" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    enabled             = var.target_group_health_check["enabled"]
    interval            = var.target_group_health_check["interval"]
    path                = var.target_group_health_check["path"]
    port                = var.target_group_health_check["port"]
    protocol            = var.target_group_health_check["protocol"]
    healthy_threshold   = var.target_group_health_check["healthy_threshold"]
    unhealthy_threshold = var.target_group_health_check["unhealthy_threshold"]
    timeout             = var.target_group_health_check["timeout"]
    matcher             = var.target_group_health_check["matcher"]
  }
}

# Register EC2 Instance with Target Group

resource "aws_lb_target_group_attachment" "tga" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.instance_id
  port             = var.target_group_port
}

# Listener Rule

resource "aws_lb_listener_rule" "forward_rule" {
  listener_arn = aws_lb_listener.https_listener.arn
  condition {
    host_header {
      values = var.forward_rule_host_header
    }
  }
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
  priority = var.forward_rule_priority
}



