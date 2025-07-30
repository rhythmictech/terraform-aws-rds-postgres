module "password" {
  source  = "rhythmictech/secretsmanager-random-secret/aws"
  version = "~>1.2.0"

  name_prefix = "${var.name}-rds-master-password"
  description = "${var.name} database password (username ${var.username})"

  create_secret    = local.create_password_secret
  length           = var.password_length
  override_special = "#%^*()-=_+{};?,."
  pass_version     = var.pass_version
  tags             = var.tags
}

