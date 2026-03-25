# 1. Network Tier
module "vpc" {
  source               = "../../modules/vpc"
  env                  = "dev"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
}

# 2. Application Tier
module "compute" {
  source             = "../../modules/compute"
  env                = "dev"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  instance_type      = "t3.micro"
  ami_id             = "ami-0ec0e125bb6c6e8ec"
  desired_capacity   = 1
}

# 3. Database Tier
module "db" {
  source             = "../../modules/db"
  env                = "dev"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  app_sg_id          = module.compute.app_sg_id # Getting SG from Compute module
  db_password        = "SuperSecretPassword123" # In prod, use a Secret Manager!
}
