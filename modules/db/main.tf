# 1. DB Subnet Group (Groups our private subnets for RDS)
resource "aws_db_subnet_group" "this" {
  name       = "${var.env}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = { Name = "${var.env}-db-subnet-group" }
}

# 2. Security Group for RDS (The "Gatekeeper")
resource "aws_security_group" "db_sg" {
  name   = "${var.env}-db-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 5432 # PostgreSQL port
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.app_sg_id] # ONLY allow the App Tier SG
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 3. The RDS Instance
resource "aws_db_instance" "this" {
  allocated_storage      = 20
  db_name                = var.db_name
  engine                 = "postgres"
  engine_version         = "16.10"
  instance_class         = var.instance_class
  username               = var.db_user
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = true                             # Only for Dev/Learning!
  multi_az               = var.env == "prod" ? true : false # HA for Prod
}
