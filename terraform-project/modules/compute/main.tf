#### Ec2 instance creation
resource "aws_instance" "ec2" {
    ami = var.ami_id
    instance_type = var.instance-type
    subnet_id = var.subnet_id
    key_name = var.key_name
    vpc_security_group_ids = [var.security_group]
    iam_instance_profile = var.instance_profile

    tags = merge(
        var.common_tags,
        var.tags,
        {Name = var.vm_name}
  )
  
}