## Creating  Instance TG

resource "aws_lb_target_group" "tg" {
    name = "${var.tg_name}-${var.environment}"
    port = var.tg_port
    protocol = "HTTP"
    target_type = "instance"
    vpc_id = var.tg_vpc_id
    health_check {
        path = "/login"
    }

    tags = merge(
        var.common_tags,
        {Name = "${var.tg_name}-${var.environment}"}
    )
  
}

## Creating AWS Launch Template

### Filtering or Getting our pre backed AMI

resource "aws_launch_template" "lt" {
    name = "${var.lt_name}-${var.environment}"
    image_id = var.image_id
    key_name = var.pem_key_name
    instance_type = var.instance_type
    iam_instance_profile {
        name = var.instance_profile 
    }
    vpc_security_group_ids = var.security_group-lt  

    tag_specifications {
      resource_type = "instance"
      tags = merge(
        var.common_tags,
        {Name = "${var.instance_name}-${var.environment}"}
     )   
    }

    tags = merge(
        var.common_tags,
        {Name = "${var.lt_name}-${var.environment}"}
  )   
    
}

### Creating ASG

resource "aws_autoscaling_group" "asg" {
    name = "${var.asg_name}-${var.environment}"
    desired_capacity = 1
    max_size = 1
    min_size = 1
    health_check_type = "EC2"
    vpc_zone_identifier = var.asg_subnets_id

    launch_template {
        id = aws_launch_template.lt.id
        version = aws_launch_template.lt.latest_version
    }
    
}


### Attach ASG to Target Group

resource "aws_autoscaling_attachment" "name" {
    autoscaling_group_name = aws_autoscaling_group.asg.id
    lb_target_group_arn = aws_lb_target_group.tg.arn
}

### creating ALB

resource "aws_lb" "alb" {
    name = "${var.alb_name}-${var.environment}"
    internal = false
    load_balancer_type = "application"
    security_groups = var.alb_security_group
    subnets = var.alb_subnets_ids

    tags = merge(
        var.common_tags,
        { Name = "${var.alb_name}-${var.environment}" }
    )
  
}

### Adding listiners to ALB

############ 443 Listiner #######

resource "aws_lb_listener" "https" {
    load_balancer_arn = aws_lb.alb.arn
    port = 443
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-2016-08"
    certificate_arn = var.alb_certificate_arn

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.tg.arn
      
    }

}

######## 80 Listiner and redirecting port 80 to 443 #########

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.alb.arn
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


