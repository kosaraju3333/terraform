#### Create NAT Gataway 
resource "aws_nat_gateway" "portal-vpc-nat" {
    allocation_id = aws_eip.nat-eip.id
    subnet_id = aws_subnet.portal-vpc-public-subnet-1.id
    tags = {
        Name = var.portal-vpc-NAT-gateway-name
        Owner = var.owner
    }
}



