####### DB section ########
# Create SG for Database client
resource "aws_security_group" "sg_db_client" {
  vpc_id = var.vpc_id
  name   = "sg_db_client"

  tags = {
    Name = "WP Database Client SG"
    Env  = var.env
  }
}

# Create SG for Database
resource "aws_security_group" "sg_db" {
  vpc_id = var.vpc_id
  name   = "sg_db"

  tags = {
    Name = "WP Database SG"
    Env  = var.env
  }
}
# Create ingress SG rule for sg_db which allow traffic from sg_db_client on port 3306
resource "aws_security_group_rule" "rule_data_client" {
  security_group_id        = aws_security_group.sg_db.id
  type                     = "ingress"
  from_port                = 0
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_db_client.id # Security group id to allow access to/from, depending on the type
}

###### Cache section ######
# Create SG for Cache Client
resource "aws_security_group" "sg_cache_client" {
  vpc_id = var.vpc_id
  name   = "sg_cache_client"

  tags = {
    Name = "WP Cache Client SG"
    Env  = var.env
  }
}

# Create SG for Cache
resource "aws_security_group" "sg_cache" {
  vpc_id = var.vpc_id
  name   = "sg_cache"

  tags = {
    Name = "WP Cache SG"
    Env  = var.env
  }
}

# Create ingress rule for sg_cache which allow traffic from sg_cache_client on port 11211
resource "aws_security_group_rule" "rule_cache_client" {
  security_group_id        = aws_security_group.sg_cache.id
  type                     = "ingress"
  from_port                = 0
  to_port                  = 11211
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_cache_client.id
}