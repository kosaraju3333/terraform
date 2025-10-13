module "network" {
    source = "./modules/network"
    vpc_name = "Portal-VPC"
    vpc-cidr-block = "10.0.0.0/24"
    public_subnet_cidrs = ["10.0.0.0/27", "10.0.0.32/27"]
    private_subnet_cidrs = ["10.0.0.96/27", "10.0.0.160/27"]
    igw_name = "portal-vpc-IGW"
    public_RT_name = "portal-VPC-Public-RT"
    private_RT_name = "portal-VPC-Private-RT"
    nat_name = "portal-vpc-nat"
    eip_name = "portal-vpc-nat-eip"
}

module "security" {
    source = "./modules/security"
    vpc_id = module.network.portal-vpc-id
}

module "ec2" {
    source = "./modules/compute"
    vm_name = "Terraform-text-VM"
    instance-type = "t2.small"
    ami_id = "ami-0360c520857e3138f"
    subnet_id = module.network.public-subnets[0]
    key_name = "my_work"
    security_group = module.security.sg-ids["ec2"]
    instance_profile = "EC2-S3-Full_Access"
  
}

