# output "sg-ids" {
#     description = "All security group IDs"
#     value = {
#         for key, sg in aws_security_group.sg : key => sg.id
#     } 
# }

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}

output "vpc_endpoint_sg_id" {
    value = aws_security_group.vpc_endpoint_sg.id
  
}
output "mysql_rds_sg" {
    value = aws_security_group.mysql_rds_sg.id
}

output "aws_acm_certificate_arn" {
    value = data.aws_acm_certificate.ssl-cert.arn 
}