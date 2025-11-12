#### Creating Private Route Table and association with private subnets 

resource "aws_route_table" "portal-vpc-main-private-RT" {
    vpc_id = aws_vpc.portal-vpc.id

    ### Creating Route to Private RT or Enabled Internet access to Public RT Via NAT Gateway
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.portal-vpc-nat.id
    }

    tags = {
      Name = var.portal-vpc-private-main-RT-name
      Owner = var.owner
    }
}

#### Private Subnets association to Route Table

resource "aws_route_table_association" "portal-vpc-private-subnet-1-RT-association" {
    subnet_id = aws_subnet.portal-vpc-private-subnet-1.id
    route_table_id = aws_route_table.portal-vpc-main-private-RT.id
}

resource "aws_route_table_association" "portal-vpc-private-subnet-2-RT-association" {
    subnet_id = aws_subnet.portal-vpc-private-subnet-2.id
    route_table_id = aws_route_table.portal-vpc-main-private-RT.id
}