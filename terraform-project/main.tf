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
