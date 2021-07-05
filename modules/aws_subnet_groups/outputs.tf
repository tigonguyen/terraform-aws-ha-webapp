output "db_subnet_group_name" {
  value = aws_db_subnet_group.rds_subnet_group.name
}

output "cache_subnet_group_name" {
  value = aws_elasticache_subnet_group.elasticache_subnet_group.name
}