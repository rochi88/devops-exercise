locals {
  create_vpc = var.vpc.create_vpc
}

resource "aws_vpc" "new_vpc" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.subnet_configs)
  vpc_id                  = resource.aws_vpc.new_vpc.id
  cidr_block              = var.subnet_configs[count.index].subnet_cidr_blocks
  availability_zone       = var.subnet_configs[count.index].availability_zone
  map_public_ip_on_launch = var.subnet_configs[count.index].allow_public_ip

  tags = {
    Name = var.subnet_configs[count.index].name
  }
}

resource "aws_internet_gateway" "new_igw" {
  vpc_id = resource.aws_vpc.my_vpc.id

  tags = {
    Name = var.igw
  }
}

resource "aws_nat_gateway" "new_nat_gateway" {
  subnet_id = resource.aws_subnet.public_subnet.id

  tags = {
    Name = var.nat_gateway_subnet
  }
}