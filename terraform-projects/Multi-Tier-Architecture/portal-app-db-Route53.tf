### Crerating Route53 for DB Instance


resource "aws_route53_record" "portal-db-app-Route53-record" {
    zone_id = var.route53-private-zone-id
    name = "db"
    type = "A"
    ttl  = 60
    records = [ aws_instance.portal-app-db-instance.private_ip ]
}