#### Creating Public Route Table and association with public subnets 

resource "aws_route_table" "portal-vpc-main-public-RT" {
    vpc_id = aws_vpc.portal-vpc.id

    ### Creating Route to Public RT or Enabled Internet access to Public RT
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.portal-vpc-igw.id
    }

    tags = {
      Name = var.portal-vpc-public-main-RT-name
      Owner = var.owner
    }
}

#### Public Subnets association to Route Table

resource "aws_route_table_association" "portal-vpc-public-subnet-1-RT-association" {
    subnet_id = aws_subnet.portal-vpc-public-subnet-1.id
    route_table_id = aws_route_table.portal-vpc-main-public-RT.id
}

resource "aws_route_table_association" "portal-vpc-public-subnet-2-RT-association" {
    subnet_id = aws_subnet.portal-vpc-public-subnet-2.id
    route_table_id = aws_route_table.portal-vpc-main-public-RT.id
}