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
    rds_name = "mysql-rds-sg"
    vpc_cidr_block = module.network.vpc_cidr_block
}

module "ec2" {
    source = "./modules/compute"
    vm_name = "Bank-app-test-VM"
    instance-type = "t2.medium"
    ami_id = "ami-id"
    subnet_id = module.network.public-subnets[0]
    key_name = "my_work"
    security_group = module.security.sg-ids["ec2"]
    instance_profile = "bank-app"
    private_key_path = "pem_key path"
    enable_remote_exec = "true"
    script_path = "script_path/nginx_install.sh"      
}

module "secrets" {
    source = "./modules/secrets"
}

module "rds" {
    source = "./modules/rds"
    rds_subnet_group_name = "mysql_rds_subnet_group"
    subnet_ids = module.network.private-subnets
    identifier = "my-sql-db"
    engine_version = "8.0"
    instance_class = "db.t3.micro"
    allocated_storage = "20"
    storage_type = "gp2"

    db_name = module.secrets.db_name
    username = module.secrets.db_username
    password = module.secrets.db_password
    port = "3306"

    vpc_security_group_ids = [module.security.mysql_rds_sg]
    rds_name = "my-mysql-db-test"
    skip_final_snapshot = true
}

module "router3" {
    source = "./modules/route53"
    zone_id = "Private Hosted Zone ID"
    vpc_id = module.network.portal-vpc-id
    route53-private-zone-id = "Private Hosted Zone ID"
    recored_name = "bank-db"
    rds_endpoint = module.rds.mysql_rds_address
    vpc_region = "us-east-1"
}

