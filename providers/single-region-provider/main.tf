# Configure the AWS Provider

##### Single Region Provider Block #####
provider "aws" {
    region = "us-east-1"
}
########################################

# Crrating ec2 instance
resource "aws_instance" "prometheus-VM" {
    ami = "ami-ID"
    instance_type = "t2.small"
    subnet_id = "subnet-ID"
    key_name = "pem.key"
}
