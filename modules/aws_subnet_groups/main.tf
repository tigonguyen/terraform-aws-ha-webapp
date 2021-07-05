# For RDS
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_subnet_group"
  subnet_ids = [var.data_a_id, var.data_b_id]

  tags = {
    Name = "RDS Subnet Group"
    Env  = var.env
  }
}

# For Elasticache
resource "aws_elasticache_subnet_group" "elasticache_subnet_group" {
  name = "elasticache-subnet-group"
  subnet_ids = [var.data_a_id, var.data_b_id]

  tags = {
    Name = "RDS Subnet Group"
    Env  = var.env
  }
}