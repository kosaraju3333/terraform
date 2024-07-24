variable "EKS_Cluster_Name" {
  description = "Declear EKS Cluster Name"
}

variable "Cluster_IAM_Role" {
  description = "Declear Cluster IAM Role"
}

variable "public_subnet_id_1" {
  description = "Declear public subnet_id_1"
}

variable "public_subnet_id_2" {
  description = "Declear public subney_id_2"
}

variable "private_subnet_id_1" {
  description = "Declear private subney_id_1"
}

variable "private_subnet_id_2" {
  description = "Declear private subney_id_2"
}

variable "tag_name" {
  description = "Provide Tag Name"
}

variable "node_group_name" {
  description = "Give node_group_name"  
}

variable "node_group_role_arn" {
  description = "Give node_group_role_arn"
}