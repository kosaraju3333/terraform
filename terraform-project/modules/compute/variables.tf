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
  type = map(string)
  default = {
    "Environment" = "Dev"
    "Owner" = "Ramakrishna"
  }
}

variable "tags" {
  type = map(string)
  default = { }
}

variable "vm_name" {
    type = string
  
}

