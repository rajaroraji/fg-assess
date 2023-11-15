resource "aws_subnet" "public_subnets" {
  for_each = var.public_subnet_cidrs
  cidr_block = each.value
  availability_zone = "${var.region}${each.key}"
  vpc_id = var.vpc_id
  tags = var.tags
}

resource "aws_subnet" "private_subnets" {
  for_each = var.private_subnet_cidrs
  cidr_block = each.value
  availability_zone = "${var.region}${each.key}"
  vpc_id = var.vpc_id
  tags = var.tags
}