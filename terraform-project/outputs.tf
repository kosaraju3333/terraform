output "portal-vpc-id" {
    description = "The ID of the portal vpc"
    value = module.network.portal-vpc-id
}

# output "vpc_cidr_block" {
#     description = "VPC cidr block"
#     value = module.network.vpc_cidr_block
# }

# output "public-subnets-ids" {
#     description = "Public subnets Id's"
#     value = module.network.public-subnets
# }

# output "private-subnets-ids" {
#     description = "Private subnets Id's"
#     value = module.network.private-subnets
# }

# output "ec2-ID" {
#     description = "EC2 VM ID"
#     value = module.ec2.ec2_instance-id
# }

# output "my-sql-RDS-address" {
#     value = module.rds.mysql_rds_address
  
# }