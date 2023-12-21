provider "aws" {
  region = "us-east-1"
}

provider "vault" {

  address = "http://IP:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "role_id"
      secret_id = "secrete_id"
    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "kv"
  name = "vm-name"
}

resource "aws_instance" "ec2" {
  ami = "ami-ID"
  instance_type = "t2.micro"
  subnet_id = "subnet-ID"
  key_name = "pem.key"
  tags = {
    Name = data.vault_kv_secret_v2.example.data["name"]
    Owner = "DevOps-Team"
  }
}