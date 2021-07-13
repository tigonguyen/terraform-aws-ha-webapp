# Create target group which lb will route traffic to
resource "aws_lb_target_group" "instance_lbtg" {
  name             = "instance-lbtg"
  port             = 80
  protocol         = "HTTP"
  protocol_version = "HTTP1"
  vpc_id           = var.vpc_id
}

# Link the target group with instances


# Define a load balancer on AWS
resource "aws_lb" "alb_wp" {
  name               = "alb-wp"
  internal           = false

  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  subnets            = [var.app_a_id, var.app_b_id]
  security_groups    = [var.lb_sg_id]
  enable_http2       = false 

  tags = {
    Name = "WP LB"
    Env  = var.env
  }
}

# Binding LB for listening to the target group