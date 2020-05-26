output "address" {
  description = "The hostname of the RDS instance. See also endpoint and port."
  value       = aws_db_instance.this.address
}

output "instance" {
  description = "Map with address, id, and username keys"
  value = {
    address  = aws_db_instance.this.address
    id       = aws_db_instance.this.id
    username = aws_db_instance.this.username
  }
}

output "instance-id" {
  description = "The RDS instance ID."
  value       = aws_db_instance.this.id
}

output "password-arn" {
  description = "The ARN of the SecretManager Secret."
  value       = aws_secretsmanager_secret.password.arn
}

output "password-version" {
  description = "The unique identifier of the version of the secret."
  value       = aws_secretsmanager_secret_version.password_val.version_id
}

output "username" {
  description = "The master username for the database."
  value       = aws_db_instance.this.username
}
