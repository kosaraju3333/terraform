terraform {
  backend "s3" {
    bucket = "terraform-spontansolutions"
    key    = "Multi-Tier-Architecture/terraform.tfstate"
    region = "us-east-1"
  }
}