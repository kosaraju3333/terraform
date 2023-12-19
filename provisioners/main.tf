provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "nginx-terraform-sg" {
  name        = "nginx-terraform-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "nginx-terraform-sg"
  }
}

resource "aws_instance" "ec2_provisioners" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  key_name = "my_work"
  vpc_security_group_ids = [ aws_security_group.nginx-terraform-sg.id ]
  tags = {
    "Name" = "naginx-terraform-provisioners-VM"
    "Owner" = "DevOps"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("~/pem key path")
    host = self.public_ip
  }

  provisioner "file" {
    source = "nginx_install.sh"
    destination = "/home/ubuntu/nginx_install.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
        "sudo apt-get update",
        "sudo chmod +x /home/ubuntu/nginx_install.sh",
        "sudo sh /home/ubuntu/nginx_install.sh"
     ]
  }
}


 