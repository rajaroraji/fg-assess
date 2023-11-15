output "public_subnet_ids" {
  value = { for k, subnet in aws_subnet.public_subnets: k => subnet.id }
}

output "private_subnet_ids" {
  value = { for k, subnet in aws_subnet.private_subnets: k => subnet.id }
}