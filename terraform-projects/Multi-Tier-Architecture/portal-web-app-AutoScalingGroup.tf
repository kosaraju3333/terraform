### Creating ASG

# resource "aws_autoscaling_group" "portal-web-ASG" {
#     availability_zones = ["us-east1a","us-east-1b"]


#     # launch_template {
#     #     id = aws_launch_template.portal-web-LT.id
#     #     version = "$Latest"
#     }
# }

resource "aws_autoscaling_group" "portal-web-asg" {
    name = "portal-web-asg"
    desired_capacity   = 1
    max_size           = 1
    min_size           = 1
    health_check_type  = "EC2"
    vpc_zone_identifier = [aws_subnet.portal-vpc-public-subnet-1.id, aws_subnet.portal-vpc-public-subnet-2.id ]
    
    launch_template {
        id      = aws_launch_template.portal-web-LT.id
        version = aws_launch_template.portal-web-LT.latest_version
  }
}

### Attach ASG to Target Group

resource "aws_autoscaling_attachment" "portal-web-ASG-TG" {
    autoscaling_group_name = aws_autoscaling_group.portal-web-asg.id
    lb_target_group_arn = aws_lb_target_group.portal-web-app-TG.arn
}