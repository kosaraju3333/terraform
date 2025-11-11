output "ec2_instance-id" {
    description = "Ec2 instance id"
    value = aws_instance.ec2.id 
}