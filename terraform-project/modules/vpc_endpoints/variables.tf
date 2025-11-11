variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
    description = "VPC ID"
    type = string
  
}

variable "aws_region" {
    description = "AWS Region"
    type = string
}

variable "private_route_table" {
    description = "Private Route Table"
    type = list(string)
}

variable "vpc_s3_endpoint_name" {
    description = "Vpc Endpoint Name"
    type = string
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type = map(string)
}

variable "private_subnet_ids" {
    description = "Private Subnets"
    type = list(string)
}

variable "vpc_endpoint_sg" {
    description = "VPC endpoint SG"
    type = list(string)
}

variable "vpc_secretmanager_endpoint_name" {
    description = "Name of VPC endpoint"
    type = string 
}
