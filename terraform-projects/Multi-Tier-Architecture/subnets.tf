#### Creating Two Public Subnets and 2 Private Subnets ####

    ##### Creating 1st Public Subnet #####
resource "aws_subnet" "portal-vpc-public-subnet-1" {
    vpc_id = aws_vpc.portal-vpc.id
    cidr_block = var.public-subnet-1-cidir
    availability_zone = var.availability-zone-1
    map_public_ip_on_launch = "true"

    tags = {
        Name = var.public-subnet-1-name
        Owner = var.owner
    }
}

    #### Creating 2nd Public Subnet ####
resource "aws_subnet" "portal-vpc-public-subnet-2" {
    vpc_id = aws_vpc.portal-vpc.id
    cidr_block = var.public-subnet-2-cidir
    availability_zone = var.availability-zone-2
    map_public_ip_on_launch = "true"

    tags = {
        Name = var.public-subnet-2-name
        Owner = var.owner
    }
}

    #### Creating 1st Private Subnet ####
resource "aws_subnet" "portal-vpc-private-subnet-1" {
    vpc_id = aws_vpc.portal-vpc.id
    cidr_block = var.private-subnet-1-cidir
    availability_zone = var.availability-zone-1

    tags = {
        Name = var.private-subnet-1-name
        Owner = var.owner
    }
}

    #### Creating 2nd Privare Subnet ####
resource "aws_subnet" "portal-vpc-private-subnet-2" {
    vpc_id = aws_vpc.portal-vpc.id
    cidr_block = var.private-subnet-2-cidir
    availability_zone = var.availability-zone-2

    tags = {
        Name = var.private-subnet-2-name
        Owner = var.owner
    }
}