resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id

  tags = {
    Name = "WP Internet Gateway"
    Env  = var.env
  }
}