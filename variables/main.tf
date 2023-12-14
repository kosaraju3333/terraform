## Configuring AWS Provider
provider "aws" {
  region = "us-east-1"
}

############## Input Variable Block ###########
variable "input_instance_type" {
  description = "Input variable for instance type"
  type = string
  default = "t2.micro"
}

variable "input_subnet_id" {
  description = "Input variable for subnet ID"
  type = string
  default = "subnet-084a18eae9dbb2283"
}
#################################################

resource "aws_instance" "ec2-useast-1" {
  ami = "ami-031bc7545ba35f815"
  instance_type = var.input_instance_type
  key_name = "my_work"
  subnet_id = var.input_subnet_id
}

######### Output Variable Block ###########
output "output_public_ip" {
  description = "Output variable to print Public Ip address"
  value = resource.aws_instance.ec2-useast-1.public_ip
}
