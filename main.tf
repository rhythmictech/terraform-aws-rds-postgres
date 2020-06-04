terraform {
  required_providers {
    random = ">= 2.2.0"
  }
}

locals {
  ssm_path = coalesce(var.ssm_path, "/db/${var.name}/${var.username}-password")
}

resource "aws_db_instance" "this" {
  allocated_storage                   = var.storage
  backup_retention_period             = var.backup_retention_period
  copy_tags_to_snapshot               = true
  db_subnet_group_name                = aws_db_subnet_group.this.id
  deletion_protection                 = true
  engine                              = var.engine
  engine_version                      = var.engine_version
  iam_database_authentication_enabled = var.iam_db_auth
  identifier                          = var.identifier
  instance_class                      = var.instance_class
  multi_az                            = var.multi_az
  name                                = var.name
  password                            = random_password.password.result
  port                                = var.port
  storage_encrypted                   = true
  storage_type                        = var.storage_type
  final_snapshot_identifier           = "${var.name}-final-snapshot"
  skip_final_snapshot                 = var.skip_final_snapshot
  username                            = var.username
  vpc_security_group_ids              = [aws_security_group.this.id]

  enabled_cloudwatch_logs_exports = [
    "postgresql",
    "upgrade",
  ]

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name}-postgres-db"
    },
  )
}

resource "aws_db_subnet_group" "this" {
  subnet_ids = var.subnet_ids

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name}-subnet-group"
    },
  )
}

resource "aws_security_group" "this" {
  vpc_id = var.vpc_id

  ingress {
    from_port        = var.port
    to_port          = var.port
    protocol         = "tcp"
    security_groups  = var.allowed_security_groups
    cidr_blocks      = var.allowed_cidr_blocks
    ipv6_cidr_blocks = var.allowed_ipv6_cidr_blocks
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name}-security-group"
    },
  )
}

resource "random_password" "password" {
  length           = 40
  special          = true
  min_special      = 5
  override_special = "!#%^&*()-_=+[]{}<>?"

  keepers = {
    pass_version = var.pass_version
  }
}

resource "aws_secretsmanager_secret" "password" {
  count       = var.create_secretmanager_secret ? 1 : 0
  name_prefix = var.name
  description = "${var.name} database password"

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name}-pass-secret"
    },
  )
}

resource "aws_secretsmanager_secret_version" "password_val" {
  count         = var.create_secretmanager_secret ? 1 : 0
  secret_id     = join("", aws_secretsmanager_secret.password[*].id)
  secret_string = random_password.password.result
}

resource "aws_ssm_parameter" "password" {
  count       = var.create_ssm_secret ? 1 : 0
  name        = local.ssm_path
  description = "${var.name} database password"
  type        = "SecureString"
  value       = random_password.password.result

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name}-pass-secret"
    },
  )
}
