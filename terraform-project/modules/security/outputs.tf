output "sg-ids" {
    description = "All security group IDs"
    value = {
        for key, sg in aws_security_group.sg : key => sg.id
    } 
}

output "mysql_rds_sg" {
    value = aws_security_group.mysql_rds_sg.id
}

