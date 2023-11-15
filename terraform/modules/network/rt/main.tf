resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id
  tags = merge(var.tags, {"private": "true"})
}

resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id
  tags = merge(var.tags, {"private": "false"})
}

resource "aws_route_table_association" "private_subnet_associations" {
  for_each = var.private_subnets
  subnet_id      = each.value
  route_table_id = aws_route_table.private_route_table.id
  depends_on = [aws_route_table.private_route_table]
}

resource "aws_route_table_association" "public_subnet_associations" {
  for_each = var.public_subnets
  subnet_id      = each.value
  route_table_id = aws_route_table.public_route_table.id
  depends_on = [aws_route_table.public_route_table]
}

resource "aws_route" "outbound_gw" {
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  depends_on = [aws_route_table.public_route_table]
  gateway_id = var.gateway_id
}

resource "aws_route" "nat_gw_route" {
  route_table_id = aws_route_table.private_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  depends_on = [aws_route_table.private_route_table]
  nat_gateway_id = var.nat_gateway_id
}