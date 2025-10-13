#### Create Subnet Group for RDS
resource "aws_db_subnet_group" "rds_subnet_group" {
    subnet_ids = var.subnet_ids

    tags = merge(
        var.common_tags,
        var.tags,
        {Name = var.rds_subnet_group_name}
  )
}

#### Create the RDS Instance

resource "aws_db_instance" "mysql_rds" {
    identifier = var.identifier
    engine = "mysql"
    engine_version = var.engine_version
    instance_class = var.instance_class
    allocated_storage = var.allocated_storage
    storage_type = var.storage_type

    db_name = var.db_name
    username = var.username
    password = var.password
    port = var.port

    db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
    vpc_security_group_ids =  var.vpc_security_group_ids

    multi_az = var.multi_az
    publicly_accessible = var.publicly_accessible
    skip_final_snapshot = var.skip_final_snapshot

    backup_retention_period = 1
    deletion_protection = var.deletion_protection

    tags = merge(
        var.common_tags,
        var.tags,
        {Name = var.rds_name}
  )
}