variable "env" {
  description = "Environment name (dev/prod)"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where security groups will be created"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the Auto Scaling Group"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type (e.g., t3.micro for dev, t3.medium for prod)"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
  # Tip: Use a standard Amazon Linux 2023 AMI for your region
}

variable "desired_capacity" {
  description = "Number of EC2 instances to run"
  type        = number
  default     = 2
}

variable "min_size" {
  type    = number
  default = 1
}

variable "max_size" {
  type    = number
  default = 3
}
