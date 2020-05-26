output "password-arn" {
  value = aws_secretsmanager_secret.password.arn
}

output "password-version" {
  value = aws_secretsmanager_secret_version.password_val.version_id
}

output "instance" {
  value = {
    id       = aws_db_instance.this.id
    username = aws_db_instance.this.username
    address  = aws_db_instance.this.address
  }
}

output "instance-id" {
  value = aws_db_instance.this.id
}

output "username" {
  value = aws_db_instance.this.username
}

output "address" {
  value = aws_db_instance.this.address
}
