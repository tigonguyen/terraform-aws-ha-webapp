resource "aws_elasticache_cluster" "main" {
  engine               = "memcached"
  engine_version       = "1.5.16"
  cluster_id           = "wp-memcached"
  node_type            = "cache.t2.small"
  num_cache_nodes      = 1
  port                 = 11211
  parameter_group_name = "default.memcached1.5"

  security_group_ids   = [var.cache_sg_id]
  subnet_group_name    = var.cache_subnet_group_name
}