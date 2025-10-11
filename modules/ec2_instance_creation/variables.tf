variable "ami_id_value" {
  description = "Declearing ami_id value"
}

variable "instance_type_value" {
  description = "Declearing instance_type value"
}

variable "subnet_id_value" {
  description = "Declearing subnet_id value"
}

variable "key_name_value" {
  description = "Declearing key_nmae value"
}

variable "common_tags" {
  type = map(string)
  default = {
    "Environment" = "Dev"
    "Owner" = "ramakrishna"
  }
}

variable "tags" {
  type = map(string)
  default = { }
}
