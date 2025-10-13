output "portal-vpc-id" {
    description = "The ID of the portal vpc"
    value = module.network.portal-vpc-id
}

output "public-subnets-ids" {
    description = "Public subnets Id's"
    value = module.network.public-subnets
}

output "private-subnets-ids" {
    description = "Private subnets Id's"
    value = module.network.private-subnets
}

output "ec2-ID" {
    description = "EC2 VM ID"
    value = module.ec2.ec2_instance-id
}
