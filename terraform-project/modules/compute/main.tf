#### Ec2 instance creation
resource "aws_instance" "ec2" {
    ami = var.ami_id
    instance_type = var.instance-type
    subnet_id = var.subnet_id
    key_name = var.key_name
    vpc_security_group_ids = [var.security_group]
    iam_instance_profile = var.instance_profile

    tags = merge(
        var.common_tags,
        var.tags,
        {Name = var.vm_name}
  )
  
}

#### Using Provisioners
## Remote-exec, File provisioners

resource "null_resource" "remote_exec" {
  count = var.enable_remote_exec ? 1 : 0

  depends_on = [ aws_instance.ec2 ]

  connection {
    type = "ssh"
    host = aws_instance.ec2.public_ip
    user = "ubuntu"
    private_key = file(var.private_key_path)
  }

  provisioner "file" {
    source = var.script_path
    destination = "/home/ubuntu/nginx_install.sh"
    
  }

  provisioner "remote-exec" {
    inline = [  
      "sudo chmod +x /home/ubuntu/nginx_install.sh",
      "sudo sh /home/ubuntu/nginx_install.sh"
    ]
    
  }
  
}