## Creating Instance TG

resource "aws_lb_target_group" "portal-web-app-TG" {
    name = "portal-web-app-TG"
    port = 80
    protocol = "HTTP"
    target_type = "instance"
    vpc_id = aws_vpc.portal-vpc.id
    health_check {
        path = "/"
    }
    tags = {
        Name = var.portal-web-app-TG-name
        Owner = var.owner
    }
}