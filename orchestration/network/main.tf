terraform {
  backend "s3" {}
}

module "vpc" {
  source = "../../modules/network/vpc"
  vpc_tags = merge(
    var.tags,
    {
      Name = "${var.env}-vpc"
    }
  )

  vpc_cidr_block = var.vpc_cidr_block
}

module "subnets" {
  source = "../../modules/network/subnet"
  region = var.region
  public_subnet_cidrs = lookup(var.subnet_cidrs, "public")
  private_subnet_cidrs = lookup(var.subnet_cidrs, "private")
  vpc_id = module.vpc.id
  tags = merge(
    var.tags,
    {
      Name = "${var.env}-subnet"
    }
  )
}

module "internet_gateway" {
  source = "../../modules/network/ig"
  vpc_id = module.vpc.id
  tags = merge(
    var.tags,
    {
      Name = "${var.env}-igw"
    }
  )
}

module "nat_gw_eip" {
  source = "../../modules/network/eip"
  tags = merge(
    var.tags,
    {
      Name = "${var.env}-gw-eip"
    }
  )
}

module "nat_gw" {
  source = "../../modules/network/nat_gw"
  subnet_id = lookup(module.subnets.public_subnet_ids, "a")
  eip_allocation_id = module.nat_gw_eip.id
  tags = merge(
    var.tags,
    {
      Name = "${var.env}-ngw"
    }
  )
}

module "route_tables" {
  source = "../../modules/network/rt"
  vpc_id = module.vpc.id
  gateway_id = module.internet_gateway.id
  nat_gateway_id = module.nat_gw.id
  public_subnets = module.subnets.public_subnet_ids
  private_subnets = module.subnets.private_subnet_ids
  tags = merge(
    var.tags,
    {
      Name = "${var.env}-route-table-${module.vpc.id}"
    }
  )
}


# Create the VPC peering connection
resource "aws_vpc_peering_connection" "vpc_peering" {
  peer_owner_id           = "<accepter_account_id>"  # Replace with the AWS account ID of the accepter VPC
  peer_vpc_id             = "<accepter_vpc_id>"      # Replace with the ID of the accepter VPC
  vpc_id                  = module.vpc.id     # Replace with the ID of the requester VPC
  auto_accept             = true
  peer_region             = "<accepter_region>"      # Replace with the region of the accepter VPC
  allow_remote_vpc_dns_resolution = true

  tags = {
    Name = "vpc-peering-connection"
  }
}

provider "aws" {
  region = var.region
}
