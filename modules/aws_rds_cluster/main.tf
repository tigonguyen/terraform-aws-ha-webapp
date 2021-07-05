# Get secret for workshop
data "vault_generic_secret" "ha_web" {
  path = "aws/ha_web"
}

# Define Aurora MySQL db cluster
resource "aws_rds_cluster" "main" {
  cluster_identifier     = "wp-rd-cluster"
  master_username        = "wpadmin"
  master_password        = data.vault_generic_secret.ha_web.data["master_password"]
  availability_zones     = ["${var.region}a", "${var.region}b"]
  database_name          = "database1"

  engine                 = "aurora-mysql"
  engine_version         = "5.7.mysql_aurora.2.03.2"
  engine_mode            = "provisioned"

  db_subnet_group_name   = var.db_subnet_group_name
  port                   = 3306

  vpc_security_group_ids = [var.db_sg_id]

  skip_final_snapshot    = true
  apply_immediately      = true

  tags = {
    Name = "WP Aurora Cluster"
    Env  = var.env
  }
}