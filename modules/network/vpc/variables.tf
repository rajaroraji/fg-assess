variable "vpc_cidr_block" {
  description = "CIDR block for vpc"
  type = string
}

variable "vpc_tags" {
  description = "tags for vpc"
  type = map
  default = {
    "managed-by": "terraform"
  }
}
