terraform {
  backend "s3" {
    bucket       = "three-tier-app-infra-bucket"
    key          = "dev/terraform.tfstate" # <--- DEV PATH
    region       = "ap-south-1"
    use_lockfile = true
  }
}
