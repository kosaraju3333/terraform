output "portal-vpc-id" {
    value = aws_vpc.portal-vpc.id
}

# output "vpc_cidr_block" {
#     value = aws_vpc.portal-vpc.cidr_block
  
# }

# output "public-subnets" {
#     value = aws_subnet.public[*].id
# }

# output "private-subnets" {
#     value = aws_subnet.private[*].id
  
# }