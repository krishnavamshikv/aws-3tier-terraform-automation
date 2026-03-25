variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "env" {
  description = "The environment name (e.g., dev, prod)"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "AZs to deploy subnets into"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}
