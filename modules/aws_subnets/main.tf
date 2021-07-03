resource "aws_subnet" "public_subnet_a" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_public_a
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.env}_Public_A"
    Env  = "${var.env}"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_public_b
  availability_zone = "${var.region}b"

  tags = {
    Name = "${var.env}_Public_B"
    Env  = "${var.env}"
  }
}

resource "aws_subnet" "app_subnet_a" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_app_a
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.env}_Application_A"
    Env  = "${var.env}"
  }
}

resource "aws_subnet" "app_subnet_b" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_app_b
  availability_zone = "${var.region}b"

  tags = {
    Name = "${var.env}_Application_B"
    Env  = "${var.env}"
  }
}

resource "aws_subnet" "data_subnet_a" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_data_a
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.env}_Data_A"
    Env  = "${var.env}"
  }
}

resource "aws_subnet" "data_subnet_b" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_data_b
  availability_zone = "${var.region}b"

  tags = {
    Name = "${var.env}_Data_B"
    Env  = "${var.env}"
  }
}