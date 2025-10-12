#### VPC Creation Resource
resource "aws_vpc" "portal-vpc" {
  cidr_block = var.vpc-cidr-block
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  tags = merge(
    var.common_tags,
    var.tags,
    {Name = var.vpc_name}
  )
}

#### Subnets Creation Resources
    #### Creating 2 Public Subnest

data "aws_availability_zones" "available" {}

resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidrs)
    
    vpc_id = aws_vpc.portal-vpc.id
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = data.aws_availability_zones.available.names[count.index]
    map_public_ip_on_launch = "true"

    tags = merge(
    var.common_tags,
    var.tags,
    {Name = "Public-Subnet-${count.index + 1}"}

  )  
}

resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidrs)
    
    vpc_id = aws_vpc.portal-vpc.id
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = data.aws_availability_zones.available.names[count.index]

    tags = merge(
    var.common_tags,
    var.tags,
    {Name = "Private-Subnet-${count.index + 1}"}

  )  
}
