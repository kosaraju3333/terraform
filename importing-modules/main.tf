provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source = "../modules/ec2_instance_creation"
  ami_id_value = "ami-id"
  instance_type_value = "t2.micro"
  subnet_id_value = "subnet-id"
  key_name_value = "pem_key"
}
