output "address" {
  value = aws_db_instance.this.address
}

output "instance" {
  value = {
    address  = aws_db_instance.this.address
    id       = aws_db_instance.this.id
    username = aws_db_instance.this.username
  }
}

output "instance-id" {
  value = aws_db_instance.this.id
}

output "password-arn" {
  value = aws_secretsmanager_secret.password.arn
}

output "password-version" {
  value = aws_secretsmanager_secret_version.password_val.version_id
}

output "username" {
  value = aws_db_instance.this.username
}
