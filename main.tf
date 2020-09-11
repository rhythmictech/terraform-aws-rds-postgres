terraform {
  required_providers {
    random = ">= 2.2.0"
  }
}

locals {
  create_password_secret    = var.password == null && var.create_secretmanager_secret ? true : false
  create_password_parameter = var.password == null && var.create_ssm_secret ? true : false
  final_snapshot_identifier = var.final_snapshot_identifier == null ? "${var.name}-final-snapshot" : var.final_snapshot_identifier
  parameter_group_name      = length(var.parameters) > 0 ? aws_db_parameter_group.this[0].name : null
  password                  = try(module.password.secret, random_password.password[0].result, var.password)
  sg_name_prefix            = "${var.name}-access"
  ssm_path                  = coalesce(var.ssm_path, "/db/${var.name}/${var.username}-password")

  db_tags = merge(
    var.tags,
    {
      "Name" = "${var.name}-postgres"
    },
  )

  sg_tags = merge(
    var.tags,
    map(
      "Name", "${var.name}-access"
    )
  )
}

resource "aws_db_parameter_group" "this" {
  count = length(var.parameters) > 0 ? 1 : 0

  name_prefix = "${var.name}-param"

  family = "postgres${var.engine_version}"

  dynamic "parameter" {
    iterator = each
    for_each = var.parameters

    content {
      name  = each.value.name
      value = each.value.value
    }
  }
}

resource "aws_db_instance" "this" {
  allocated_storage                   = var.storage
  backup_retention_period             = var.backup_retention_period
  copy_tags_to_snapshot               = true
  db_subnet_group_name                = var.subnet_group_name
  deletion_protection                 = var.enable_deletion_protection
  enabled_cloudwatch_logs_exports     = var.cloudwatch_log_exports
  engine                              = "postgres"
  engine_version                      = var.engine_version
  final_snapshot_identifier           = local.final_snapshot_identifier
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  identifier                          = var.identifier
  identifier_prefix                   = var.identifier_prefix
  instance_class                      = var.instance_class
  multi_az                            = var.multi_az
  name                                = var.name
  password                            = local.password
  performance_insights_enabled        = var.performance_insights_enabled
  port                                = var.port
  skip_final_snapshot                 = var.skip_final_snapshot
  storage_encrypted                   = true
  storage_type                        = var.storage_type
  tags                                = local.db_tags
  username                            = var.username
  vpc_security_group_ids              = [aws_security_group.this.id]
}
