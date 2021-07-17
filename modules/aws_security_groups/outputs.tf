output "db_sg_id" {
  value = aws_security_group.sg_db.id
}

output "cache_sg_id" {
  value = aws_security_group.sg_cache.id
}

output "fs_sg_id" {
  value = aws_security_group.sg_fs.id
}

output "lb_sg_id" {
  value = aws_security_group.sg_lb.id
}

output "wp_sg_id" {
  value = aws_security_group.sg_wp_server.id
}

output "db_client_sg_id" {
  value = aws_security_group.sg_db_client.id
}

output "fs_client_sg_id" {
  value = aws_security_group.sg_fs_client.id
}

output "cache_client_sg_id" {
  value = aws_security_group.sg_cache_client.id
}