# 🏗️ AWS Highly Available Infrastructure with Terraform

This project provisions a **highly available (HA)** and **modular** AWS infrastructure using **Terraform**.  
The setup includes a complete **3-tier architecture** with networking, compute, database, DNS, and security — all automated using Infrastructure as Code (IaC).

---

## 🚀 Project Overview

This Terraform project creates and configures the following AWS resources:

- **VPC** with 4 subnets — 2 Public and 2 Private  
- **Route Tables** for both public and private subnets  
- **Internet Gateway (IGW)** attached to the public route table  
- **NAT Gateway** in public subnet for private subnet internet access  
- **VPC Endpoints:**
  - **S3 Gateway Endpoint** — to access S3 from private EC2  
  - **Secrets Manager Interface Endpoint** — to securely fetch secrets  
- **Security Groups** for EC2, ALB, RDS, VPC Endpoints, and Jumpbox  
- **Private RDS Instance** with internal DNS record in **Private Route53 Hosted Zone**  
- **Launch Template (LT)** with custom AMI and startup scripts  
- **Auto Scaling Group (ASG)** across private subnets  
- **Application Load Balancer (ALB)** in public subnets with:
  - HTTP (80) → HTTPS (443) redirection  
  - SSL certificate from AWS ACM  
- **Route53 Records:**
  - Public hosted zone for ALB DNS  
  - Private hosted zone for internal RDS DNS  
- **Secrets Manager** for storing and accessing application credentials  

The **AMI** used in the Launch Template contains a **systemd service** that automatically starts the application on boot.

---

## 🧱 Project Structure

```bash
├── modules/
│   ├── network/          # VPC, Subnets, Route Tables, IGW, NAT, VPC Endpoints
│   ├── compute/          # ALB, ASG, Launch Template, EC2
│   ├── rds/              # RDS Database creation
│   ├── route53/          # Public and Private DNS records
│   ├── secrets/          # AWS Secrets Manager integration
│   ├── security/         # Security Groups and SSL Certificate
│
├── main.tf               # Root Terraform file importing all modules
├── variables.tf          # Variables used across modules
├── outputs.tf            # Outputs of created resources
├── provider.tf           # AWS provider configuration
└── backend.tf            # Remote state configuration (S3 backend)
```

## ⚙️ Terraform Features Used
- Modularization — Each resource category is isolated for reusability
- Workspaces — For managing multiple environments (e.g., dev, prod)
- Remote State — Stored in S3 for collaboration and consistency
- Count — Used for creating multiple subnets dynamically
- Provisioners (file, remote-exec) — to automate tasks
- Variable and Output Management — Clean and structured configuration

🧩 Terraform Commands Used
```bash
# Initialize the project
terraform init

# Validate the syntax and configuration
terraform validate

# Preview infrastructure changes
terraform plan

# Apply changes to create resources
terraform apply

# Create and manage multiple workspaces
terraform workspace new <workspace_name>
terraform workspace list
terraform workspace select <workspace_name>
```


## 🔐 Security Implementation
- Security groups follow least privilege principles
- VPC Endpoint SG allows access on port 443 only from private EC2
- Private RDS accessible only within private subnets
- SSL/TLS termination at ALB using AWS ACM certificates
- Secrets fetched securely from AWS Secrets Manager

## 🧠 High Availability Design
- Multi-AZ setup across two Availability Zones
- Auto Scaling Group ensures fault tolerance and elasticity
- NAT Gateway and VPC Endpoints ensure secure private subnet connectivity
- ALB distributes incoming traffic evenly across private EC2s

## 🌐 DNS and SSL
- Public Route53 Record — Points domain to ALB DNS
- Private Route53 Record — Internal DNS for RDS
- SSL Certificates — Managed via AWS Certificate Manager (ACM)

## 🧰 Tools and Technologies
- Terraform (Infrastructure as Code)
- AWS Services: VPC, EC2, ALB, RDS, Route53, Secrets Manager, ACM, NAT, IGW
- S3 Backend for Terraform remote state
- Systemd Service for auto-starting the application from AMI

## 🧾 Notes
- AMI used in Launch Template contains startup script for app launch
- Each environment (dev, stage, prod) is maintained using Terraform workspaces
- All outputs (ALB DNS, RDS endpoint, etc.) are defined in module level outputs.tf
