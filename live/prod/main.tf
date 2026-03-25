# 1. Network Tier (Prod)
module "vpc" {
  source               = "../../modules/vpc"
  env                  = "prod"
  vpc_cidr             = "10.1.0.0/16" # Different range than Dev
  public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnet_cidrs = ["10.1.3.0/24", "10.1.4.0/24"]
  availability_zones   = ["ap-south-1a", "ap-south-1b"]
}

# 2. Application Tier (Prod)
module "compute" {
  source             = "../../modules/compute"
  env                = "prod"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids

  instance_type    = "t2.small" # Production Grade Instance
  ami_id           = "ami-0ec0e125bb6c6e8ec"
  desired_capacity = 3 # Higher capacity for Prod
  min_size         = 2
  max_size         = 5
}

# 3. Database Tier (Prod)
module "db" {
  source             = "../../modules/db"
  env                = "prod"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  app_sg_id          = module.compute.app_sg_id
  instance_class     = "db.t3.small"
  db_password        = "ProdSecurePassword99!" # Use Secrets Manager in real life
}
