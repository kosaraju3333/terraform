output "portal-vpc-id" {
  description = "The ID of the portal VPC"
  value = aws_vpc.portal-vpc.id
}