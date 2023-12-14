output "output_public_ip_address" {
  value = aws_instance.ec2-us-east-1.public_ip
}

output "output_private_ip_address" {
  value = aws_instance.ec2-us-east-1.private_ip
}

