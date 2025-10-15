variable "environment" {
  description = "Environment name"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type = map(string)
}

variable "zone_id" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "vpc_region" {
    type = string
}

variable "route53-private-zone-id" {
    type = string
}

variable "recored_name" {
    type = string
}

variable "rds_endpoint" {
    type = string
  
}