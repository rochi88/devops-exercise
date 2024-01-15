variable "create_vpc" {
  description = "Control if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the VPC"
  type        = string
  default     = ""
}

variable "cidr" {
  description = "CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_configs" {
  type = list(object({
    subnet_cidr_blocks = string,
    name               = string,
    allow_public_ip    = bool,
    availability_zone  = string
  }))
}

variable "igw" {
  type = string
}

variable "nat_gateway_subnet" {
  type = string
}