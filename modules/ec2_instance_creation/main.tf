
resource "aws_instance" "ec2-us-east-1" {
  ami = var.ami_id_value
  instance_type = var.instance_type_value
  subnet_id = var.subnet_id_value
  key_name = var.key_name_value 
  tags = merge(
    var.common_tags,
    var.tags
  )
}
