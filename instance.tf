resource "aws_db_instance" "mysql" {
  allocated_storage                   = var.storage
  backup_retention_period             = var.backup_retention_period
  copy_tags_to_snapshot               = true
  db_subnet_group_name                = aws_db_subnet_group.mysql.id
  deletion_protection                 = true
  engine                              = "mysql"
  engine_version                      = var.mysql_version
  iam_database_authentication_enabled = true
  instance_class                      = var.instance_class
  multi_az                            = var.multi_az
  password                            = random_string.password.result
  port                                = var.port
  storage_encrypted                   = true
  storage_type                        = var.storage_type
  final_snapshot_identifier           = "${var.name}-final-snapshot"
  skip_final_snapshot                 = var.skip_final_snapshot
  username                            = var.username
  vpc_security_group_ids              = [aws_security_group.mysql.id]

  enabled_cloudwatch_logs_exports = [
    "audit",
    "error",
    "general",
    "slowquery",
  ]

  tags = merge(
    local.base_tags,
    var.tags,
    {
      "Name" = "${var.name}-mysql-db"
    },
  )
}

