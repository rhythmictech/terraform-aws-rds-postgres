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

resource "random_password" "password" {
  count = local.create_password_parameter ? 1 : 0

  length           = var.password_length
  special          = true
  override_special = "#$%^*()-=_+[]{};<>?,."

  keepers = {
    pass_version = var.pass_version
  }
}

resource "aws_ssm_parameter" "password" {
  count = local.create_password_parameter ? 1 : 0

  name = local.ssm_path

  description = "${var.name} database password (username ${var.username})"
  type        = "SecureString"
  value       = random_password.password[0].result

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name}-pass-secret"
    },
  )
}
