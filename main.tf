resource "aws_security_group" "sg" {
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
      "Name" = "${var.name}-postgres-sg"
    },
  )
}

module "db-password" {
  source           = "git::https://github.com/rhythmictech/terraform-secretsmanager-random-secret?ref=v0.0.5"
  name             = "${var.name}-db-master-password"
  description      = join("", [var.name, "database password (username ", var.username, ")"])
  tags             = var.tags
  length           = 40
  special          = true
  min_special      = 3
  override_special = "#$%^&*()-_=+[]{}<>:?"
  pass_version     = var.pass_version
}


resource "aws_db_instance" "this" {
  allocated_storage                   = var.storage
  backup_retention_period             = var.backup_retention_period
  copy_tags_to_snapshot               = true
  db_subnet_group_name                = var.subnet_group_name
  deletion_protection                 = true
  engine                              = "postgres"
  engine_version                      = var.engine_version
  iam_database_authentication_enabled = var.iam_database_authentication
  identifier_prefix                   = var.identifier_prefix
  instance_class                      = var.instance_class
  multi_az                            = var.multi_az
  name                                = var.db_name == "" ? null : var.db_name
  password                            = module.db-password.secret
  port                                = var.port
  storage_encrypted                   = var.storage_encrypted
  storage_type                        = var.storage_type
  final_snapshot_identifier           = "${var.name}-final-snapshot"
  skip_final_snapshot                 = var.skip_final_snapshot
  username                            = var.username
  vpc_security_group_ids              = [aws_security_group.sg.id]

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
