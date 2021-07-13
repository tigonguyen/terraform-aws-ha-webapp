# Define a file system
resource "aws_efs_file_system" "main" {
  creation_token   = "efs-cluster"
  throughput_mode  = "bursting"
  performance_mode = "generalPurpose"

  tags = {
    Name = "WP FS Cluster"
    Env  = var.env
  }
}

# Set mount to app subnet A
resource "aws_efs_mount_target" "mount_target_a" {
  file_system_id = aws_efs_file_system.main.id
  subnet_id      = var.app_a_id
  security_groups = [var.fs_sg_id]
}

# Set mount to app subnet B
resource "aws_efs_mount_target" "mount_target_b" {
  file_system_id = aws_efs_file_system.main.id
  subnet_id      = var.app_b_id
  security_groups = [var.fs_sg_id]
}