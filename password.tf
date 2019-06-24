resource "random_string" "password" {
  length           = 40
  special          = true
  min_special      = 5
  override_special = "!#$%^&*()-_=+[]{}<>:?"

  keepers = {
    pass_version = var.pass_version
  }
}

resource "aws_secretsmanager_secret" "mysql-pass" {
  description = "MySQL database password"

  tags = merge(
    local.base_tags,
    var.tags,
    {
      "Name" = "${var.name}-mysql-pass-secret"
    },
  )
}

resource "aws_secretsmanager_secret_version" "password-val" {
  secret_id     = aws_secretsmanager_secret.mysql-pass.id
  secret_string = random_string.password.result
}

