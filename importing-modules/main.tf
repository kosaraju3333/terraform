provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source = "../modules/ec2_instance_creation"
  ami_id_value = ""
  instance_type_value = "t2.micro"
  subnet_id_value = ""
  key_name_value = ""
}
