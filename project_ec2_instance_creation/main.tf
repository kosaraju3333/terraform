# Configure the AWS Provider
provider "aws" {
    region = "us-east-1"
}

# Crrating ec2 instance
resource "aws_instance" "prometheus-VM" {
    ami = "ami-031bc7545ba35f815"
    instance_type = "t2.small"
    subnet_id = "subnet-084a18eae9dbb2283"
    key_name = "my_work"
}
