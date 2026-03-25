variable "env" { type = string }
variable "vpc_id" { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "app_sg_id" { type = string }

variable "db_name" { default = "mydb" }
variable "db_user" { default = "adminuser" }
# We use Secrets Manager for passwords in real projects for demo lets use variable
variable "db_password" {
  type      = string
  sensitive = true
}

variable "instance_class" { default = "db.t3.micro" }
