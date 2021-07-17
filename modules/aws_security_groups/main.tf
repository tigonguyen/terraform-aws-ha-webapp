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
  description              = "Ingress SG rule for sg_db which allow traffic from sg_db_client on port 3306" 
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
  description              = "Ingress rule for sg_cache which allow traffic from sg_cache_client on port 11211"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 11211
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_cache_client.id
}

####### FS section #######
# Create SG for FS client
resource "aws_security_group" "sg_fs_client" {
  vpc_id = var.vpc_id
  name   = "sg_fs_client"

  tags = {
    Name = "WP FS Client SG"
    Env  = var.env
  }
}

# Create SG for FS
resource "aws_security_group" "sg_fs" {
  vpc_id = var.vpc_id
  name   = "sg_fs"

  tags = {
    Name = "WP FS SG"
    Env  = var.env
  }
}

# Create ingress rule for sg_fs which allow traffic from sg_fs_client on port 2049
resource "aws_security_group_rule" "rule_fs_client" {
  security_group_id        = aws_security_group.sg_fs.id
  description              = "Ingress rule for sg_fs which allow traffic from sg_fs_client on port 2049" 
  type                     = "ingress"
  from_port                = 0
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_fs_client.id
}

###### LB section ######
# Create SG for LB
resource "aws_security_group" "sg_lb" {
  vpc_id = var.vpc_id
  name   = "sg_lb"

  tags = {
    Name = "WP LB SG"
    Env  = var.env
  }
}

# Add Inbound rule which allow traffic from 0.0.0.0/0 on port 80
resource "aws_security_group_rule" "rule_lb" {
  security_group_id = aws_security_group.sg_lb.id
  description       = "Inbound rule which allow traffic from 0.0.0.0/0 on port 80" 
  type              = "ingress"
  from_port         = 0
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

###### Wordpress server section #######
# Create security group
resource "aws_security_group" "sg_wp_server" {
  vpc_id = var.vpc_id
  name   = "sg_wp_server"

  tags = {
    Name = "WP Server SG"
    Env  = var.env
  }
}

# Add Inbound rule which allow trafic from sg_lb on port 80
resource "aws_security_group_rule" "rule_wp" {
  security_group_id        = aws_security_group.sg_wp_server.id
  description              = "Ingress rule for sg_fs which allow traffic from sg_fs_client on port 2049" 
  type                     = "ingress"
  from_port                = 0
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_lb.id
}