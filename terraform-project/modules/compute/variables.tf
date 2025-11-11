variable "environment" {
  description = "Environment name"
  type        = string
}

### Target Group Variables ####
variable "tg_name" {
    description = "Target Group Name"
    type = string
}

variable "tg_port" {
    description = "Target Port"
    type = string
}

variable "tg_vpc_id" {
    description = "Tatget Group VPC id"
    type = string
}

#### Launch Tempelete Variables

variable "lt_name" {
    description = "Launch Templete Name"
    type = string
}

variable "image_id" {
    description = "Image ID"
    type = string
}
variable "pem_key_name" {
    description = "Pem key Name"
    type = string
}

variable "instance_type" {
    description = "Instance type"
    type = string
}

variable "security_group-lt" {
    description = "security group"
    type = list(string)
}

variable "instance_profile" {
    description = "IAM role for EC2"
    type = string
}

variable "instance_name" {
    description = "Instance Name"
    type = string
}

#### ASG Variables ####

variable "asg_name" {
    description = "ASG Name"
    type = string
}

variable "asg_subnets_id" {
    description = ""
    type = list(string)
}


#### ALB Variables ####

variable "alb_name" {
    description = "ALB Name"
    type = string
}

variable "alb_security_group" {
    description = "ALB Security Group"
    type = list(string)
  
}

variable "alb_subnets_ids" {
    description = "ALB Subnets"
    type = list(string)
  
}

variable "alb_certificate_arn" {
    description = "SSL Cerificate ARN"
    type = string
  
}


variable "common_tags" {
  description = "Common tags to apply to all resources"
  type = map(string)
}