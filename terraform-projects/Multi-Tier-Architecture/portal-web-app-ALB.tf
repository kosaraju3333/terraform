### Creating ALB

resource "aws_lb" "portal-web-app-alb" {
    name = "Portal-web-app-ALB"
    internal = false
    load_balancer_type = "application"
    security_groups = [ aws_security_group.portal-web-sg.id ]
    subnets = [ aws_subnet.portal-vpc-public-subnet-1.id, aws_subnet.portal-vpc-public-subnet-2.id ]

    tags = {
      Owner = var.owner
    }
}

### Adding listiners to ALB

############ 443 Listiner #######
resource "aws_lb_listener" "portal-app-rule_https" {
  load_balancer_arn = aws_lb.portal-web-app-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.ssl_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.portal-web-app-TG.arn
  }
}

######### 80 Listiner and redirecting port 80 to 443 #########
resource "aws_lb_listener" "portal-app-rule_http" {
  load_balancer_arn = aws_lb.portal-web-app-alb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }

  }
}