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

#### ALB DNS variables

variable "route53-public-zone-id" {
    description = "Public Hosted Zone ID"
    type = string
}

variable "alb_recored_name" {
    description = "Recored name"
    type = string
}

variable "alb_dns_name" {
    description = "alb dns value"
    type = list(string)
}