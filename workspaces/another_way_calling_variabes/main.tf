provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2" {
  ami = var.ami_id
  subnet_id = var.subnet_id
  instance_type = var.instance_type
  key_name = "my_work"
  tags = {
    Name = var.instance_name
    Owner = "DevOps"
  }
}