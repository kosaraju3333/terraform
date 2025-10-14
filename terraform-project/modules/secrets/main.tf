data "aws_secretsmanager_secret" "bank_app_secrets" {
    name = "prod/bankapp/mysql"
}

data "aws_secretsmanager_secret_version" "bank_app_secrets_value" {
    secret_id = data.aws_secretsmanager_secret.bank_app_secrets.id
  
}

locals {
    bank_app_secrets = jsondecode(data.aws_secretsmanager_secret_version.bank_app_secrets_value.secret_string)
  
}