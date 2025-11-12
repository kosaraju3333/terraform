variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc-cidr-block" {
    description = "CIDR Block for VPC"
}

variable "vpc_name" {
  type        = string
  description = "Custom VPC name tag"
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type = map(string)
}

# variable "tags" {
#   type = map(string)
#   default = { }
# }

variable "public_subnet_cidrs" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

# variable "availability_zones" {
#   type = list(string)
#   default = ["us-east-1a", "us-east-1a"]
# }

variable "private_subnet_cidrs" {
  type = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "igw_name" {
    type = string
}

variable "eip_name" {
    type = string 
}

variable "nat_name" {
    type = string
}

variable "public_RT_name" {
    type = string
}

variable "private_RT_name" {
    type = string
}