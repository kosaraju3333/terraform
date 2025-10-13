variable "security_groups" {
    type = map(object({
      description = string
      ingress = list(object({
        from_port = number
        to_port = number
        protocol = string
        cidr_block = list(string) 
      })) 
    }))

    default = {
      "ec2" = {
        description = "Allow SSH, HTTP and HTTPS for EC2"
        ingress = [
        {
          cidr_block = [ "0.0.0.0/0" ]
          from_port = 22
          protocol = "tcp"
          to_port = 22
        },
        {
          cidr_block = [ "0.0.0.0/0" ]
          from_port = 80
          protocol = "tcp"
          to_port = 80

        },
        {
          cidr_block = [ "0.0.0.0/0" ]
          from_port = 443
          protocol = "tcp"
          to_port = 443
        },
        {
          cidr_block = [ "0.0.0.0/0" ]
          from_port = 5050
          protocol = "tcp"
          to_port = 5050

        },
        {
          cidr_block = [ "0.0.0.0/0" ]
          from_port = -1
          protocol = "icmp"
          to_port = -1

        }

      ]
      
      }

    "db" = {
        description = "Allow Postgres an MySQL access"
        ingress = [
        {
          cidr_block = [ "0.0.0.0/0" ]
          from_port = 5432
          protocol = "tcp"
          to_port = 5432
        },
        {
          cidr_block = [ "0.0.0.0/0" ]
          from_port = 3306
          protocol = "tcp"
          to_port = 3306

        }
      ]
      
      }

    }
  
}

variable "vpc_id" {
  type = string
}

variable "common_tags" {
  type = map(string)
  default = {
    "Environment" = "Dev"
    "Owner" = "Ramakrishna"
  }
}

variable "tags" {
  type = map(string)
  default = { }
}

variable "rds_name" {
    type = string
}

variable "vpc_cidr_block" {
  type = string
}