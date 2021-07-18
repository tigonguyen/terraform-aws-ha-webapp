# Define a load balancer on AWS
resource "aws_lb" "alb_wp" {
  name                             = "alb-wp"
  internal                         = false

  load_balancer_type               = "application"
  ip_address_type                  = "ipv4"
  subnets                          = [var.app_a_id, var.app_b_id]
  security_groups                  = [var.lb_sg_id]
  enable_http2                     = false
  enable_cross_zone_load_balancing = true

  tags = {
    Name = "WP LB"
    Env  = var.env
  }
}

# Listener is binding on LB
resource "aws_lb_listener" "alb_wp_listener" {
  load_balancer_arn = aws_lb.alb_wp.arn
  protocol          = "HTTP"
  port              = 80
  default_action {
    type             = "redirect"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

# Create target group which lb will route traffic to
resource "aws_lb_target_group" "alb_tg" {
  name             = "alb-tg"
  port             = 80
  protocol         = "HTTP"
  protocol_version = "HTTP1"
  vpc_id           = var.vpc_id
}