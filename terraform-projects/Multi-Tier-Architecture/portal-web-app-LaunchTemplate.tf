## Creating AWS Launch Template

### Filtering or Getting our pre backed AMI

data "aws_ami" "portal-app-LT-ami" {

    filter {
        name = "tag:Name"
        values = ["Portal-app-AMI-V-03-spontansolutions.com"]
    }
}

resource "aws_launch_template" "portal-web-LT" {
    name = "portal-web-LT"
    image_id = data.aws_ami.portal-app-LT-ami.id
    key_name = "my_work"
    instance_type = var.portal-web-instance-type
    vpc_security_group_ids = [ aws_security_group.portal-web-sg.id]
    iam_instance_profile {
        name = "EC2-S3-Full_Access"
    }

    tag_specifications {
        resource_type = "instance"

        tags = {
            Name = "Portal-web-app"
        }
  }

    tags = {
        Name = var.portal-web-LT-name
        Owner = var.owner
    }
}