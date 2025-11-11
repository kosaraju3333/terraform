##############################
# ALB Security Group
##############################
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow HTTP/HTTPS from internet"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    { Name = "alb-sg-${var.environment}" }
  )
}

##############################
# EC2 Security Group
##############################
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Allow traffic from ALB"
  vpc_id      = var.vpc_id

  # Allow incoming app traffic from ALB SG
  ingress {
    description      = "Allow app traffic from ALB"
    from_port        = 5050
    to_port          = 5050
    protocol         = "tcp"
    security_groups  = [aws_security_group.alb_sg.id]
  }

  # Allow SSH from Bastion/Your IP (optional)
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # optional
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    { Name = "ec2-sg-${var.environment}" }
  )
}

##############################
# VPC interface endpoint Security Group
##############################
resource "aws_security_group" "vpc_endpoint_sg" {
  name        = "vpc_endpoint_sg"
  description = "Allow traffic from EC2 to VPC Interface Endpoint"
  vpc_id      = var.vpc_id

  # Allow incoming app traffic from ALB SG
  ingress {
    description      = "Allow app traffic from ALB"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    security_groups  = [aws_security_group.ec2_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    { Name = "vpc_endpoint_sg-${var.environment}" }
  )
}

#### Create RDS security group
resource "aws_security_group" "mysql_rds_sg" {
    name = var.rds_name
    description = "Allow MySQL traffic"
    vpc_id = var.vpc_id

    tags = merge(
        var.common_tags,
        {Name = "${var.rds_name}-sg-${var.environment}"}
  )  
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_icmp_ipv4" {
    security_group_id = aws_security_group.mysql_rds_sg.id
    cidr_ipv4 = var.vpc_cidr_block
    from_port = -1
    to_port = -1
    ip_protocol = "icmp"  
}

resource "aws_vpc_security_group_ingress_rule" "allow_mysql_port" {
    security_group_id = aws_security_group.mysql_rds_sg.id
    cidr_ipv4 = var.vpc_cidr_block
    from_port = 3306
    to_port = 3306
    ip_protocol = "tcp"  
}


#### Fetch SSL Certificates ARN #####

data "aws_acm_certificate" "ssl-cert" {
    domain = var.domain_name
    statuses = ["ISSUED"]
    most_recent = true 
}

