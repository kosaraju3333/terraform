variable "vpc-cidr-block" {
    description = "CIDR Block for VPC"
}

variable "vpc_name" {
  type        = string
  description = "Custom VPC name tag"
}


variable "common_tags" {
  type = map(string)
  default = {
    "Environment" = "Dev"
    "Owner" = "Ramakrishna"
  }
}

variable "tags" {
  type = map(string)
  default = { }
}

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
