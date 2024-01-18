terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 0.15"
}

provider "aws" {
  region = var.region
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


