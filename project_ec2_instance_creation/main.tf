# Configure the AWS Provider
provider "aws" {
    region = "us-east-1"
}

# Crrating ec2 instance
resource "aws_instance" "prometheus-VM" {
    ami = "ami-02b91a46e15da2494"
    instance_type = "t2.small"
    subnet_id = "subnet-084a18eae9dbb2283"
    key_name = "my_work"
}
