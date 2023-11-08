
# make sure the db instii are in line with
#   dif db_instance*.tf
resource "aws_db_instance" "this_ignore" {
  count = var.ignore_engine_version_and_password_changes ? 1 : 0

  identifier        = try(substr(var.identifier, 0, 63), null)
  identifier_prefix = try(substr(var.identifier_prefix, 0, 36), null)

  allocated_storage                   = var.storage
  backup_retention_period             = var.backup_retention_period
  copy_tags_to_snapshot               = true
  db_name                             = var.database_name
  db_subnet_group_name                = var.subnet_group_name
  deletion_protection                 = var.enable_deletion_protection
  enabled_cloudwatch_logs_exports     = var.cloudwatch_log_exports
  engine                              = "postgres"
  engine_version                      = var.engine_version
  final_snapshot_identifier           = local.final_snapshot_identifier
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  instance_class                      = var.instance_class
  monitoring_interval                 = var.monitoring_interval
  monitoring_role_arn                 = local.monitoring_role_arn
  multi_az                            = var.multi_az
  parameter_group_name                = local.parameter_group_name
  password                            = local.password
  performance_insights_enabled        = var.performance_insights_enabled #tfsec:ignore:aws-rds-enable-performance-insights
  port                                = var.port
  skip_final_snapshot                 = var.skip_final_snapshot
  storage_encrypted                   = var.storage_encrypted
  storage_type                        = var.storage_type
  tags                                = local.db_tags
  username                            = var.username
  vpc_security_group_ids              = [aws_security_group.this.id]

  lifecycle {
    ignore_changes = [engine_version, password]
  }
}
