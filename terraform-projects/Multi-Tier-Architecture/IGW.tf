#### Creating Internet Gateway ####

resource "aws_internet_gateway" "portal-vpc-igw" {
    vpc_id = aws_vpc.portal-vpc.id

    tags = {
        Name = var.portal-vpc-igw-name
        Owner = var.owner
    }
}