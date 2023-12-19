output "naginx-terraform-provisioners-VM_public_ip" {
  value = aws_instance.ec2_provisioners.public_ip
}