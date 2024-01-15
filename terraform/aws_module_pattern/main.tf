# Create a VPC
module "vpc_module" {
  source = "./vpc"
  cidr   = "10.0.0.0/16"
  name   = "new_vpc"
  subnet_configs = [
    {
      subnet_cidr_blocks = "10.0.1.0/24",
      name               = "public_subnet",
      allow_public_ip    = true,
      availability_zone  = "us-east-1a"
    },
    {
      subnet_cidr_blocks = "10.0.2.0/24",
      name               = "private_subnet",
      allow_public_ip    = false,
      availability_zone  = "us-east-1b"
  }]
  igw                = "new_igw"
  nat_gateway_subnet = "nat_gateway"
}
