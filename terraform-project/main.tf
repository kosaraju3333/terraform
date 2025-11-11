module "network" {
    source = "./modules/network"
    vpc_name = "bank-VPC"
    vpc-cidr-block = "10.0.0.0/24"
    public_subnet_cidrs = ["10.0.0.0/27", "10.0.0.32/27"]
    private_subnet_cidrs = ["10.0.0.96/27", "10.0.0.160/27"]
    igw_name = "portal-vpc-IGW"
    public_RT_name = "portal-VPC-Public-RT"
    private_RT_name = "portal-VPC-Private-RT"
    nat_name = "portal-vpc-nat"
    eip_name = "portal-vpc-nat-eip"

    environment = local.environment
    common_tags = local.common_tags
}

module "security" {
    source = "./modules/security"
    vpc_id = module.network.portal-vpc-id
    rds_name = "mysql-rds-sg"
    vpc_cidr_block = module.network.vpc_cidr_block
    domain_name = "*.spontansolutions.com"

    environment = local.environment
    common_tags = local.common_tags

    depends_on = [module.network]

}

module "vpc_endpoints" {
    source = "./modules/vpc_endpoints"
    vpc_id = module.network.portal-vpc-id
    aws_region = "us-east-1"
    vpc_s3_endpoint_name = "Private-Ec2-S3"
    private_route_table = [module.network.private_RT]

    vpc_secretmanager_endpoint_name = "Private-Ec2-Secretmanager"
    private_subnet_ids = module.network.private-subnets[*]
    vpc_endpoint_sg = [module.security.vpc_endpoint_sg_id]

    environment = local.environment
    common_tags = local.common_tags
}

module "ec2" {
    source = "./modules/compute-ec2"
    vm_name = "Bank-app-test-VM"
    instance-type = "t2.medium"
    ami_id = "ami-000d547b977fbdea7"
    subnet_id = module.network.public-subnets[0]
    key_name = "my_work"
    security_group = module.security.ec2_sg_id
    instance_profile = "bank-app"
    private_key_path = "/Users/ramakrishnakosaraju/spontansolutions/keys/my_work.pem"
    enable_remote_exec = "true"
    script_path = "/Users/ramakrishnakosaraju/spontansolutions/terraform/terraform-project/scripts/nginx_install.sh"

    environment = local.environment
    common_tags = local.common_tags
          
}

module "compute" {
    source = "./modules/compute"
    #### TG variables values ####
    tg_name = "bank-app-tg"
    tg_port = "5050"
    tg_vpc_id = module.network.portal-vpc-id
    
    #### LT variables values ####
    lt_name = "bank-app-lt"
    image_id = "ami-0696fac78fbd8e963"
    pem_key_name = "my_work"
    instance_type = "t2.small"
    instance_profile = "bank-app"
    instance_name = "bank-app-VM"
    security_group-lt = [module.security.ec2_sg_id]

    #### ASG variables values ####
    asg_name = "bank-app-asg"
    asg_subnets_id = module.network.private-subnets[*]
    
    #### ALB variables values ####
    alb_name = "bank-app-alb"
    alb_security_group = [module.security.alb_sg_id]
    alb_subnets_ids = module.network.public-subnets[*]
    alb_certificate_arn = module.security.aws_acm_certificate_arn

    #### Common variables ####
    environment = local.environment
    common_tags = local.common_tags

    depends_on = [module.rds]
}

module "secrets" {
    source = "./modules/secrets"
}

module "rds" {
    source = "./modules/rds"
    app_name = "bank-app"
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

    environment = local.environment
    common_tags = local.common_tags

    depends_on = [module.security]
}

module "route53" {
    source = "./modules/route53"
    #### Private DNS variables for RDS ####
    zone_id = "Zone_ID"

    vpc_id = module.network.portal-vpc-id
    route53-private-zone-id = "Zone-ID"
    recored_name = "bank-db"
    rds_endpoint = module.rds.mysql_rds_address
    vpc_region = "us-east-1"

    #### Public hosted zone DNS variables for ALB ####
    route53-public-zone-id = "Zone-ID"
    alb_recored_name = "bank"
    alb_dns_name = [module.compute.alb_dns]

    environment = local.environment
    common_tags = local.common_tags

    depends_on = [module.rds, module.compute]
}

