output "lb_dns_name" {
  value = aws_lb.alb_wp.dns_name
}

output "tg_arn" {
  value = aws_lb_target_group.alb_tg.arn
}