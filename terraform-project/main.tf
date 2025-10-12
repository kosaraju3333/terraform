module "network" {
    source = "./modules/network"
    vpc-cidr-block = "10.0.0.0/24"
    public_subnet_cidrs = ["10.0.0.0/27", "10.0.0.32/27"]
    private_subnet_cidrs = ["10.0.0.96/27", "10.0.0.160/27"]


    vpc_name = "Portal-VPC"

}
