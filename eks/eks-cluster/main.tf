# Configure the AWS Provider
provider "aws" {
    region = "us-east-1"
}

# Creating EKS Cluster
resource "aws_eks_cluster" "terraform-test" {
    name = var.EKS_Cluster_Name
    role_arn = var.Cluster_IAM_Role

    vpc_config {
      subnet_ids = [var.private_subnet_id_1, var.private_subnet_id_2]
    }
    tags = {
    "Name" = var.tag_name
    "Owner" = "DevOps"
    }
}

# Creating Node-Group for exesting EKS Cluster
resource "aws_eks_node_group" "terraform-Cluster-node-group" {
  cluster_name = aws_eks_cluster.terraform-test.name
  node_group_name = var.node_group_name
  node_role_arn = var.node_group_role_arn
  subnet_ids = [var.private_subnet_id_1, var.private_subnet_id_2]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

   update_config {
    max_unavailable = 1
  }
}