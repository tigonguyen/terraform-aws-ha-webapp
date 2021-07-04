# Define a route table to link pulic subnets with internet gateway
resource "aws_route_table" "main" {
  vpc_id = var.vpc_id

  tags = {
    Name = "WP Public"
    Env  = var.env
  }
}

# Create route in route table to forward trafic to any IP on internet
resource "aws_route" "igw" {
  route_table_id         = aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.gateway_id
}

# Associate subnets with the route table
resource "aws_route_table_association" "public_a" {
  route_table_id = aws_route_table.main.id
  subnet_id      = var.public_a_id
}

resource "aws_route_table_association" "public_b" {
  route_table_id = aws_route_table.main.id
  subnet_id      = var.public_b_id
}