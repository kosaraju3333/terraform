### Creating WEB security group

resource "aws_security_group" "portal-db-sg" {
  name        = "portal-db-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.portal-vpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

    ingress {
    description = "HTTP from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  #     ingress {
  #   description = "HTTP from VPC"
  #   from_port   = "ALL"
  #   to_port     = "ALL"
  #   protocol    = "ICMP"
  #   cidr_blocks = [ "0.0.0.0/0" ]
  # }

  egress {
    
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "portal-db-sg"
    Owner = var.owner
  }
}