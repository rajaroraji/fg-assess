# Variables Definition

variable "name" {
  description = "Name for the Application Load Balancer"
}

variable "subnets" {
  type        = list(string)
  description = "List of subnet IDs where the ALB will be deployed"
}

variable "vpc_id" {
  description = "The VPC ID where resources will be created"
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate to attach to the ALB"
}

variable "enable_deletion_protection" {
  type        = bool
  description = "Enable deletion protection for the ALB"
  default     = false
}

variable "idle_timeout" {
  description = "Idle timeout for the ALB in seconds"
  type        = number
  default     = 60
}

variable "enable_http2" {
  description = "Enable HTTP/2 for the ALB"
  type        = bool
  default     = true
}

variable "alb_ingress_cidr_blocks" {
  description = "List of CIDR blocks to allow in ingress rule of ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "alb_egress_cidr_blocks" {
  description = "List of CIDR blocks to allow in egress rule of ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "target_group_name" {
  description = "The name of the target group"
  type        = string
}

variable "target_group_port" {
  description = "The port on which targets receive traffic"
  type        = number
}

variable "target_group_protocol" {
  description = "The protocol to use for routing traffic to the targets"
  default     = "HTTP"
  type        = string
}

variable "target_group_health_check" {
  description = "A map containing health check settings for the target group"
  type        = map(any)
  default     = {
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
}

variable "instance_id" {
  description = "The ID of the EC2 instance to register with the target group"
  type        = string
}

variable "forward_rule_host_header" {
  type        = list(string)
  description = "List of host header values for the forward rule"
}

variable "forward_rule_priority" {
  description = "Priority for the forward rule"
  type        = number
}
