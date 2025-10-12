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

#### Public and Private Subnets Creation Resources

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

    #### Creating 2 Private Subnets
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

#### Creating IGW 
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.portal-vpc.id
    tags = merge(
    var.common_tags,
    var.tags,
    {Name = var.igw_name}
  )  
}

#### Creating elastic ip
resource "aws_eip" "nat_eip" {
    domain = "vpc"
    tags = merge(
    var.common_tags,
    var.tags,
    {Name = var.eip_name}
  )
  
}

### Creating NAT
resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.public[0].id

    tags = merge(
    var.common_tags,
    var.tags,
    {Name = var.nat_name})

}

#### Creating Public Route Tables and associatetion with public subnet

    #### Public Route Table
resource "aws_route_table" "portal_vpc_public_RT" {
    vpc_id = aws_vpc.portal-vpc.id

    ### Creating Route to Public RT or Enabled Internet access to Public RT
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = merge(
    var.common_tags,
    var.tags,
    {Name = var.public_RT_name}
  )  
}
    #### Public Subnets association to Route Table

resource "aws_route_table_association" "public-subnet-RT-association" {
    count = length(aws_subnet.public)
    subnet_id = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.portal_vpc_public_RT.id
}


    #### Private Route Table
resource "aws_route_table" "portal_vpc_private_RT" {
    vpc_id = aws_vpc.portal-vpc.id

    ### Creating Route to Private RT or Enabled Internet access to Private RT Via NAT Gateway
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id
    }

    tags = merge(
    var.common_tags,
    var.tags,
    {Name = var.private_RT_name}
  )  
  
}

    #### Private Subnets association to Route Table
resource "aws_route_table_association" "private-subnet-RT-association" {
    count = length(aws_subnet.private)
    subnet_id = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.portal_vpc_private_RT.id
  
}