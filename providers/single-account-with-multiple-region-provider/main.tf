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
    ami = "ami-ID"
    instance_type = "t2.small"
    key_name = "pem.key"
    subnet_id = "subnet-ID"
    provider = aws.us-east-1

}

resource "aws_instance" "ec2-ap-south-1" {
    ami = "ami-ID"
    instance_type = "t2.small"
    key_name = "pem.key"
    provider = aws.ap-south-1

}