resource "aws_vpc" "portal-vpc" {
    cidr_block = var.vpc-cidr-block
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"

    tags = {
      Name = var.vpc-name
      Owner = var.owner
    }
}