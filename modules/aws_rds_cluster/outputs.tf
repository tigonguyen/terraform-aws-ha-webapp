output "write_instance_dns" {
  value = aws_rds_cluster_instance.cluster_instance_0.writer == true ? aws_rds_cluster_instance.cluster_instance_0.endpoint : aws_rds_cluster_instance.cluster_instance_1.endpoint
}