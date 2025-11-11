##### VPC S3 Endpoint #####

resource "aws_vpc_endpoint" "s3_gateway" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = var.private_route_table

  tags = merge(
    var.common_tags,
    {Name = "${var.vpc_s3_endpoint_name}-${var.environment}"}
  )
}


##### VPC Secretmanager  Endpoint #####

resource "aws_vpc_endpoint" "secrets_manager_interface" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.secretsmanager"
  vpc_endpoint_type = "Interface"
  subnet_ids        = var.private_subnet_ids
  security_group_ids = var.vpc_endpoint_sg
  private_dns_enabled = true

  tags = merge(
    var.common_tags,
    {Name = "${var.vpc_secretmanager_endpoint_name}-${var.environment}"}
  )
}