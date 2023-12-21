# Configuring AWS provider
provider "aws" {
  region = "us-east-1"
}

# Creating AWS VPC
resource "aws_vpc" "Terraform-VPC" {
  cidr_block = "10.0.0.0/24"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "Terraform-VPC"
  }
}

# Creating Subnet1
resource "aws_subnet" "Terraform-public-subnet-1" {
  vpc_id = aws_vpc.Terraform-VPC.id
  cidr_block = "10.0.0.0/26"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "Terraform-subnet-public"
  }
}

# Creating Subnet2
resource "aws_subnet" "Terraform-private-subnet-1" {
  vpc_id = aws_vpc.Terraform-VPC.id
  cidr_block = "10.0.0.64/26"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Terraform-subnet-private"
  }
}

# Creating Internet Gateway
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.Terraform-VPC.id
  tags = {
    Name = "Terraform-VPC-IGW"
  }
}

resource "aws_eip" "elastic_ip" {
  domain = "vpc"
  tags = {
    Name = "NAT-IP"
  }
}

# Creating Public NAT Gateway
resource "aws_nat_gateway" "NAT-GW" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id = aws_subnet.Terraform-public-subnet-1.id
}

# Creating Public Route Table and attaching Internet gateway route.
resource "aws_route_table" "Route-table-public" {
  vpc_id = aws_vpc.Terraform-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "Terraform-VPC-Route-table-public"
  }
}

# Creating Private Route Table and attaching NAT gatewat route
resource "aws_route_table" "Route-table-private" {
  vpc_id = aws_vpc.Terraform-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT-GW.id
  }
  tags = {
    Name = "Terraform-VPC-Route-table-private"
  }
}

# Association of Public Route Table to Subnet
resource "aws_route_table_association" "public_route_table_association" {
  subnet_id = aws_subnet.Terraform-public-subnet-1.id
  route_table_id = aws_route_table.Route-table-public.id
}

# Association of Private Route Table to Subnet
resource "aws_route_table_association" "private_route_table_associatio" {
  subnet_id = aws_subnet.Terraform-private-subnet-1.id
  route_table_id = aws_route_table.Route-table-private.id
}