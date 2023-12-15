provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source = "../modules/ec2_instance_creation"
  ami_id_value = "ami-031bc7545ba35f815"
  instance_type_value = "t2.micro"
  subnet_id_value = "subnet-084a18eae9dbb2283"
  key_name_value = "my_work"
}
