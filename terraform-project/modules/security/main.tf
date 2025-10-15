resource "aws_security_group" "sg" {
    for_each = var.security_groups

    name = "${each.key}-sg"
    description = each.value.description
    vpc_id = var.vpc_id

    dynamic "ingress" {
        for_each = each.value.ingress
        content {
          from_port = ingress.value.from_port
          to_port = ingress.value.to_port
          protocol = ingress.value.protocol
          cidr_blocks = ingress.value.cidr_block
        }
      
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }

    tags = merge(
        var.common_tags,
        {Name = "${each.key}-sg-${var.environment}"}
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
