resource "aws_autoscaling_group" "main" {
  name                 = "wp-workshop-asg"
  launch_configuration = var.launch_conf_name
  min_size             = 2
  max_size             = 8
  vpc_zone_identifier  = [var.app_a_id, var.app_b_id]
  target_group_arns    = [var.tg_arn]
}