resource "aws_route53_zone_association" "vpc_privateZone" {
    zone_id = var.route53-private-zone-id
    vpc_id = aws_vpc.portal-vpc.id
    vpc_region = var.region
  
}