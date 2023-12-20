provider "aws" {
  region = "us-east-1"
}

variable "ami" {
  description = "AMI Value"
}

variable "subnet" {
  description = "Subnet value"
}

variable "instance_type" {
  description = "value"
  type = map(string)

  default = {
    "dev" = "t2.micro"
    "staging" = "t2.small"
    "prod" = "t2.large"
  }
}

variable "instance_name" {
  description = "Instance name"
  type = map(string)

  default = {
    "dev" = "dev-vm"
    "staging" = "staging-vm"
    "prod" = "prod-vm"
  }
}

resource "aws_instance" "ec2" {
  ami = var.ami
  subnet_id = var.subnet
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
  key_name = "my_work"
  tags = {
    Name = lookup(var.instance_name, terraform.workspace, "test-vm")
    Owner = "DevOps"
  }
}