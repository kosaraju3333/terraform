provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source = "../modules/ec2_instance_creation"
  ami_id_value = "ami-0360c520857e3138f"
  instance_type_value = "t2.micro"
  subnet_id_value = "subnet-084a18eae9dbb2283"
  key_name_value = "my_work"
  tags = {
    Name      = "Nginx-VM"
    Component = "Web-server"
  }
}
