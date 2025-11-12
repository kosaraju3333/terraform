## Creating Elastic IP

resource "aws_eip" "nat-eip" {
  domain = "vpc"
  tags = {
    Name = var.elastic-ip-NAT-name
    Owner = var.owner
  } 
}