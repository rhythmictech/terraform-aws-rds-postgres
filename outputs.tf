output "password-arn" {
  value = aws_secretsmanager_secret.mysql-pass.arn
}

output "password-version" {
  value = aws_secretsmanager_secret_version.password-val.version_id
}

output "instance" {
  value = {
    id       = aws_db_instance.mysql.id
    username = aws_db_instance.mysql.username
    address  = aws_db_instance.mysql.address
  }
}

output "instance-id" {
  value = aws_db_instance.mysql.id
}

output "username" {
  value = aws_db_instance.mysql.username
}

output "address" {
  value = aws_db_instance.mysql.address
}

