variable "environment" {
  description = "Environment name"
  type        = string
}

variable "rds_subnet_group_name" {
    type = string
}

variable "subnet_ids" {
    type = list(string) 
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type = map(string)
}

variable "app_name" {
    type = string
}

variable "identifier" {
    type = string
}

variable "engine_version" {
    type = string
}

variable "instance_class" {
    type = string
}

variable "allocated_storage" {
    type = string
}

variable "storage_type" {
    type = string
}

variable "db_name" {
    type = string
}

variable "username" {
    type = string
}

variable "password" {
    type = string
}

variable "port" {
    type = string
}

# variable "db_subnet_group_name" {
#   type = string
# }

variable "vpc_security_group_ids" {
    type = list(string)
}

variable "multi_az" {
    type = bool
    default = false
}

variable "publicly_accessible" {
    type = bool
    default = false
}

variable "skip_final_snapshot" {
    type = bool
    default = true
}

variable "deletion_protection" {
    type = bool
    default = false
}

variable "rds_name" {
    type = string
}
