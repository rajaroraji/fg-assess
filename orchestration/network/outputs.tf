output "vpc_id" {
  value = module.vpc.id
}

output "public_subnets" {
  value = module.subnets.public_subnet_ids
}

output "private_subnets" {
  value = module.subnets.private_subnet_ids
}

output "eip_allocation_id" {
  value = module.nat_gw_eip.allocation_id
}

output "eip_id" {
  value = module.nat_gw_eip.id
}