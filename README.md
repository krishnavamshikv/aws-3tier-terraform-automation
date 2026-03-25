# High-Availability 3-Tier AWS Infrastructure with Terraform

This repository contains a production-ready, modularized Terraform configuration for deploying a scalable 3-tier architecture on AWS. It implements industry best practices for security, environment isolation, and remote state management.



## 🚀 Key Features
* **Environment Isolation:** Complete separation of `dev` and `prod` using a file-based directory structure.
* **Remote State Management:** Utilizes **Amazon S3** for state storage and **Native S3 Locking** (`use_lockfile = true`) for concurrency control.
* **Custom Modular Design:** Reusable modules for VPC, Compute (ALB/ASG), and RDS.
* **Security-First Networking:**
    * Public subnets for Load Balancers.
    * Private subnets for Application and Database tiers.
    * One-way internet access for private instances via **NAT Gateway**.
    * **Security Group Chaining:** The Database tier only accepts traffic from the Application tier.

## 🏗️ Architecture Layers
1.  **Presentation Tier:** Application Load Balancer (ALB) distributed across 2 Availability Zones.
2.  **Application Tier:** Auto Scaling Group (ASG) of EC2 instances running in private subnets.
3.  **Data Tier:** Amazon RDS (PostgreSQL) with Multi-AZ enabled for Production.

## 📂 Project Structure
```text
.
├── modules/
│   ├── vpc/      # Network foundation (IGW, NAT, Subnets)
│   ├── compute/  # ALB, ASG, Launch Templates
│   └── db/       # RDS Instance & Subnet Groups
└── live/
    ├── dev/      # Development environment (t3.micro)
    └── prod/     # Production environment (t2.small, Multi-AZ)
```

## 🛠️ Deployment Instructions

### Prerequisites
* **AWS CLI** configured with appropriate permissions.
* **Terraform v1.10+** installed.
* **S3 Bucket:** Create a bucket named `three-tier-app-infra-bucket` in `ap-south-1` to store the state files.

Initialize the backend:

```Bash
cd live/dev
terraform init
```
Plan the infrastructure:
```Bash
terraform plan
```
Apply changes:

```Bash
terraform apply
```

## 🔐 Security Note
All database passwords and sensitive variables are handled via Terraform variables. In a production CI/CD pipeline, these should be integrated with AWS Secrets Manager.
