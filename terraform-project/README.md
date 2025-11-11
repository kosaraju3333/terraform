# 🚀 AWS High Availability Infrastructure with Terraform

## 🧩 Overview
This project provisions a **highly available, secure, and modular AWS infrastructure** using **Terraform**.  
It automates the setup of a **3-tier architecture** (Web, App, DB) that includes networking, compute, database, security, DNS, and VPC endpoints.  
The design is reusable, scalable, and supports **multi-environment deployments** via **Terraform Workspaces**.

---

## 🏗️ Architecture Diagram

markdown
Copy code
                ┌───────────────────────────────┐
                │        Public Subnets         │
                │ ┌──────────────┐  ┌──────────────┐
Internet ─────────▶ │ │ ALB(443) │ │ Jumpbox EC2 │
│ └──────┬───────┘ └──────┬───────┘
└────────┼─────────────────┘
│ HTTPS(443)
┌────────┴───────────┐
│ Private Subnets │
│ ┌──────────────┐ │
│ │ ASG (EC2s) │───┼─▶ Secrets Manager (Interface Endpoint)
│ └──────────────┘ │
│ │ │
│ ▼ │
│ RDS (MySQL) ◀── S3 (Gateway Endpoint)
└─────────────────────┘

yaml
Copy code

---

## 🌐 Features

### 🧱 Networking (VPC Module)
- Creates **VPC** with **4 subnets**:  
  - 2 Public  
  - 2 Private (across two AZs)
- **Internet Gateway (IGW)** for public subnets
- **NAT Gateway** in public subnet for private subnet outbound traffic
- **Route Tables** with proper routing (public/private)
- **VPC Endpoints**:
  - **S3 Gateway Endpoint** – for S3 access from private EC2
  - **Secrets Manager Interface Endpoint** – for secret retrieval from private EC2

---

### 💻 Compute (Compute Module)
- **Launch Template (LT)** with startup script to auto-launch your app  
- **Auto Scaling Group (ASG)** deployed in private subnets across multiple AZs  
- **Application Load Balancer (ALB)** in public subnets:
  - Listener on port **443 (HTTPS)** with **ACM SSL certificate**
  - Listener on port **80** redirecting to **443**
- **Target Group (TG)** integrated with ASG instances

---

### 🗄️ Database (RDS Module)
- Creates **Private MySQL RDS Instance**
- Credentials stored and retrieved securely from **AWS Secrets Manager**
- Encrypted in transit using **SSL/TLS**
- Accessible only from EC2 security group in private subnets

---

### 🔒 Security (Security Module)
- Creates multiple **Security Groups**:
  - **ALB SG** → allows HTTP (80) & HTTPS (443) from Internet  
  - **EC2 SG** → allows app port (e.g., 5050) from ALB SG  
  - **RDS SG** → allows 3306 (MySQL) from EC2 SG  
  - **VPC Endpoint SG** → allows 443 from EC2 SG only  
  - **Jumpbox SG** → allows SSH (22) from your IP
- Fetches **ACM SSL Certificate** dynamically for ALB

---

### 🧭 Route53 (DNS Module)
- **Private Hosted Zone** → internal DNS for RDS
- **Public Hosted Zone** → maps ALB DNS name to your custom domain

---

### 🧰 Secrets Module
- Retrieves app and DB credentials from **AWS Secrets Manager**
- Enables secure access without hardcoding secrets

---

## 🧩 Project Structure

terraform-aws-infra/
│
├── modules/
│ ├── network/
│ ├── compute/
│ ├── rds/
│ ├── security/
│ ├── route53/
│ └── secrets/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── backend.tf
└── README.md

yaml
Copy code

---

## ⚙️ Terraform Concepts Used

| Feature | Description |
|----------|-------------|
| **Modules** | Clean, reusable, and organized code |
| **Workspaces** | Environment isolation (`dev`, `qa`, `prod`) |
| **Remote Backend** | State stored securely in **S3** |
| **Dynamic Blocks** | Flexible SG ingress rules |
| **for_each & count** | Efficient resource creation |
| **merge()** | Combine tags dynamically |
| **Outputs & Variables** | Cross-module communication |

---

## 🔖 Tags and Naming Convention
All resources follow environment-specific naming:
```hcl
tags = merge(
  var.common_tags,
  { Name = "${var.resource_name}-${var.environment}" }
)
Example:
bank-app-alb-dev, bank-app-rds-prod

🧠 Terraform Commands
bash
Copy code
# Initialize
terraform init

# Create or select workspace
terraform workspace new dev
terraform workspace select dev

# Validate configuration
terraform validate

# Preview resources
terraform plan -var-file="env/dev.tfvars"

# Apply configuration
terraform apply -var-file="env/dev.tfvars" -auto-approve
