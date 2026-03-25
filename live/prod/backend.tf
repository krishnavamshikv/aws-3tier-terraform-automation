terraform {
  backend "s3" {
    bucket       = "three-tier-app-infra-bucket"
    key          = "prod/terraform.tfstate" # <--- PROD PATH
    region       = "ap-south-1"
    use_lockfile = true
  }
}
