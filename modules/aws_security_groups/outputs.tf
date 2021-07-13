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