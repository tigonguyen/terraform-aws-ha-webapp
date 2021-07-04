############### For Internet gateway section ###############
# Define a route table to link pulic subnets with internet gateway
resource "aws_route_table" "table_igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "WP Public"
    Env  = var.env
  }
}

# Create route in route table to forward trafic to any IP on internet
resource "aws_route" "route_igw" {
  route_table_id         = aws_route_table.table_igw.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}

# Associate subnets with the route table
resource "aws_route_table_association" "associate_public_a" {
  route_table_id = aws_route_table.table_igw.id
  subnet_id      = var.public_a_id
}

resource "aws_route_table_association" "associate_public_b" {
  route_table_id = aws_route_table.table_igw.id
  subnet_id      = var.public_b_id
}

############### For NAT gateways section ###############
#### For App subnet A ####
# Define a route table to link app subnet A with NAT gateway
resource "aws_route_table" "table_nat_A" {
  vpc_id = var.vpc_id

  tags = {
    Name = "WP NAT Gateway A"
    Env  = var.env
  }
}

# Route trafic to NAT gateway A
resource "aws_route" "route_nat_a" {
  route_table_id         = aws_route_table.table_nat_A.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.nat_gateway_id_a
}

# Associate app subnet A with the route table
resource "aws_route_table_association" "associate_app_a" {
  route_table_id = aws_route_table.table_nat_A.id
  subnet_id      = var.app_a_id
}

#### For App subnet B ####
# Define a route table to link app subnet B with NAT gateway
resource "aws_route_table" "table_nat_B" {
  vpc_id = var.vpc_id

  tags = {
    Name = "WP NAT Gateway B"
    Env  = var.env
  }
}

# Route trafic to NAT gateway B
resource "aws_route" "route_nat_b" {
  route_table_id         = aws_route_table.table_nat_B.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.nat_gateway_id_b
}

# Associate app subnet B with the route table
resource "aws_route_table_association" "associate_app_b" {
  route_table_id = aws_route_table.table_nat_B.id
  subnet_id      = var.app_b_id
}