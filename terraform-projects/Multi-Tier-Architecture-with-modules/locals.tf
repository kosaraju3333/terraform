locals {
  environment = terraform.workspace

  common_tags = {
    Project     = "BankApp"
    Owner       = "DevOpsTeam"
    Environment = local.environment
  }
}