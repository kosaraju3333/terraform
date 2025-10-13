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
        var.tags,
        {Name = "${each.key}-sg"}
    )


  
}