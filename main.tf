locals {
  create_password_secret    = var.password == null && var.create_secretmanager_secret ? true : false
  create_password_parameter = var.password == null && var.create_ssm_secret ? true : false
  final_snapshot_identifier = var.final_snapshot_identifier == null ? "${var.name}-final-snapshot" : var.final_snapshot_identifier
  monitoring_role_arn       = try(aws_iam_role.this[0].arn, var.monitoring_role_arn)
  parameter_group_name      = length(var.parameters) > 0 ? aws_db_parameter_group.this[0].name : null
  password                  = try(var.password, module.password.secret, random_password.password[0].result)
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
    {
      "Name" = "${var.name}-access"
    }
  )
}

resource "aws_db_parameter_group" "this" {
  count = length(var.parameters) > 0 ? 1 : 0

  name_prefix = "${var.name}-param"

  family = coalesce(
    var.parameter_group_family,
    "postgres${replace(var.engine_version, "/\\.\\d+/", "")}" # strips the minor and patch digits from the version
  )

  dynamic "parameter" {
    iterator = each
    for_each = var.parameters

    content {
      apply_method = each.value.apply_method
      name         = each.value.name
      value        = each.value.value
    }
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  count              = var.monitoring_interval > 0 && var.monitoring_role_arn == null ? 1 : 0
  name_prefix        = var.name
  assume_role_policy = data.aws_iam_policy_document.this.json
}
