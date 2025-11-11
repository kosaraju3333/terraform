variable "environment" {
  description = "Environment name"
  type        = string
}

variable "ami_id" {
    type = string
}

variable "instance-type" {
    type = string
}

variable "subnet_id" {
    type = string
}

variable "key_name" {
    type = string
}

variable "security_group" {
    type = string
}

variable "instance_profile" {
    type = string
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type = map(string)
}

# variable "tags" {
#   type = map(string)
#   default = { }
# }

variable "vm_name" {
    type = string
  
}

variable "enable_remote_exec" {
    type = bool
    default = false
}

variable "private_key_path" {
  
}

variable "script_path" {
  type        = string
  description = "Local path to the script file"
}

# variable "script_destination_path" {
#     type = string
#     description = "Target path"
  
# }