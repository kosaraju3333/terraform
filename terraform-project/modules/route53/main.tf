#### Association VPC-id to private Route53 Hosted Zone
resource "aws_route53_zone_association" "vpc_private_hosted_zone" {
    zone_id = var.zone_id
    vpc_id = var.vpc_id
    vpc_region = var.vpc_region
  
}

#### Creat Route53 for RDS 

resource "aws_route53_record" "my-mysql-db-rds-route53-record" {
    zone_id = var.route53-private-zone-id
    name = var.recored_name
    type = "CNAME"
    ttl = 60
    records = [var.rds_endpoint]
}