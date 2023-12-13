###### Multiple region aws provider #####
provider "aws" {
    alias = "us-east-1"
    region = "us-east-1"
}

provider "aws" {
    alias = "ap-south-1"
    region = "ap-south-1"
}
########################################

resource "aws_instance" "ec2-us-east-1" {
    ami = "ami-031bc7545ba35f815"
    instance_type = "t2.small"
    key_name = "my_work"
    subnet_id = "subnet-084a18eae9dbb2283"
    provider = aws.us-east-1

}

resource "aws_instance" "ec2-ap-south-1" {
    ami = "ami-0a2bece398df13b9d"
    instance_type = "t2.small"
    key_name = "ap-south-1"
    provider = aws.ap-south-1

}