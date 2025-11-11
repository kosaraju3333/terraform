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
- Variable and Output Management — Clean and structured configuration
