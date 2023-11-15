variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "db_name" {
  description = "The name of the DB"
  type        = string
  default     = "mydb"
}

variable "db_username" {
  description = "Username for the DB"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Password for the DB"
  type        = string
  sensitive   = true
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 20
}

variable "multi_az" {
  description = "Whether the RDS instance is multi-AZ"
  type        = bool
  default     = true
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t2.micro"
}

variable "storage_type" {
  description = "The storage type for the RDS instance"
  type        = string
  default     = "gp2"
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "VPC ID where the RDS and security group will reside"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
variable "engine" {
  description = "The database engine to use"
  type        = string
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate"
  type        = string
}


variable "private_subnets" {
  description = "The private subnets to associate with the ASG"
  type        = list(string)
}


variable "vpc_id" {
  description = "The VPC ID where the RDS security group will be created"
  type        = string
}

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
}

variable "security_group_description" {
  description = "The description of the security group"
  type        = string
}

variable "ingress_from_port" {
  description = "The starting port range for the ingress rule"
  type        = number
}

variable "ingress_to_port" {
  description = "The ending port range for the ingress rule"
  type        = number
}

variable "ingress_protocol" {
  description = "The protocol for the ingress rule"
  type        = string
}

variable "web_security_group_id" {
  description = "ID of an additional security group to allow in ingress"
  type        = string
}

