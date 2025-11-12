terraform {
  backend "s3" {
    bucket = "terraform-spontansolutions"
    key    = "terraform-project/terraform.tfstate"
    region = "us-east-1"
  }
}
