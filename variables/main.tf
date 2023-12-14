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
  default = "subnet-ID"
}
#################################################

resource "aws_instance" "ec2-useast-1" {
  ami = "ami-ID"
  instance_type = var.input_instance_type
  key_name = "Pem_key"
  subnet_id = var.input_subnet_id
  tags = {
    "Name" = "Prometheus-VM"
    "Owner" = "DevOps"
  }
}

######### Output Variable Block ###########
output "output_public_ip" {
  description = "Output variable to print Public Ip address"
  value = resource.aws_instance.ec2-useast-1.public_ip
}
