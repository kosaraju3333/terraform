# ## Creating EC2 Instance From pre backed AMI

# ### Filtering or Getting our pre backed AMI

# data "aws_ami" "portal-app-ami" {

#     filter {
#         name = "tag:Name"
#         values = ["Portal-app-AMI-V-03-spontansolutions.com"]
#     }
# }

# ### Creating AWS EC2 instance

# resource "aws_instance" "name" {
#     ami = data.aws_ami.portal-app-ami.id
#     instance_type = var.portal-web-instance-type
#     subnet_id = aws_subnet.portal-vpc-public-subnet-1.id
#     key_name = "my_work"
#     vpc_security_group_ids = [ aws_security_group.portal-web-sg.id ]
#     iam_instance_profile = "EC2-S3-Full_Access"
#     tags = {
#         Name = var.portal-web-instance-name
#         Owner = var.owner
#     }
# }

