####### DB Client section ########
# Create SG for Database client
resource "aws_security_group" "sg_db_client" {
  vpc_id = var.vpc_id
  name   = "sg_db_client"

  tags = {
    Name = "WP Database Client SG"
    Env  = var.env
  }
}

####### DB section #######
# Create SG for Database client
resource "aws_security_group" "sg_db" {
  vpc_id = var.vpc_id
  name   = "sg_db"

  tags = {
    Name = "WP Database SG"
    Env  = var.env
  }
}
# Create ingress SG rule for sg_db which allow traffic from sg_db_client to port 3306 in sg_db
resource "aws_security_group_rule" "rule_data_client" {
  security_group_id        = aws_security_group.sg_db.id
  type                     = "ingress"
  from_port                = 0
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_db_client.id # Security group id to allow access to/from, depending on the type
}