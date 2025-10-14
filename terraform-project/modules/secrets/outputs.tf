output "db_username" {
    value = local.bank_app_secrets["dbuser"]
}

output "db_password" {
    value = local.bank_app_secrets["dbpassword"]
}

output "db_name" {
    value = local.bank_app_secrets["dbname"] 
}