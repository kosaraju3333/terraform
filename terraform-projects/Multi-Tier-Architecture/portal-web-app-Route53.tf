### Crerating Route53


resource "aws_route53_record" "portal-web-app-Route53-record" {
    zone_id = var.route53-public-zone-id
    name = "portal-app"
    type = "CNAME"
    ttl  = 60
    records = [ aws_lb.portal-web-app-alb.dns_name ]
}