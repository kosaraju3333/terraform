output "portal-vpc-id" {
    value = aws_vpc.portal-vpc.id
}

output "public-subnets" {
    value = aws_subnet.public[*].id
}

output "private-subnets" {
    value = aws_subnet.private[*].id
  
}