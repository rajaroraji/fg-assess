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

