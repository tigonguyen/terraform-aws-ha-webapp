# Create EIP for NAT gateway A
resource "aws_eip" "eip_A" {
  vpc = true
  tags = {
      Name = "EIP Public A"
      Env  = var.env
  }
}

# Create EIP for NAT gateway B
resource "aws_eip" "eip_B" {
  vpc = true
  tags = {
      Name = "EIP Public B"
      Env  = var.env
  }
}

# Create NAT gateway for App subnet A
resource "aws_nat_gateway" "NAT_gateway_A" {
  allocation_id = aws_eip.eip_A.id
  subnet_id     = var.public_a_id

  tags = {
    Name = "WP NAT Gateway A"
    Env  = var.env
  }
}

# Create NAT gateway for App subnet B
resource "aws_nat_gateway" "NAT_gateway_B" {
  allocation_id = aws_eip.eip_B.id
  subnet_id     = var.public_b_id

  tags = {
    Name = "WP NAT Gateway B"
    Env  = var.env
  }
}