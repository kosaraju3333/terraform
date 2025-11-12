### Creating Postgres DB instance in private subnet.

data "aws_ami" "portal-db-instance" {
    filter {
        name = "tag:Name"
        values = [ "Postgres-DB-AMI" ]
    }
}

resource "aws_instance" "portal-app-db-instance" {
    ami = data.aws_ami.portal-db-instance.id
    instance_type = var.portal-app-db-instance-type
    subnet_id = aws_subnet.portal-vpc-private-subnet-1.id
    key_name = "my_work"
    vpc_security_group_ids = [ aws_security_group.portal-db-sg.id ]

    tags = {
      Name = var.portal-app-db-instance-name
      Owner = var.owner
    }

}