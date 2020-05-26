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

output "instance_id" {
  description = "The RDS instance ID."
  value       = aws_db_instance.this.id
}

output "password_secretsmanager_arn" {
  description = "The ARN of the SecretManager Secret."
  value       = var.create_secretmanager_secret ? aws_secretsmanager_secret.password.arn : ""
}

output "password_secretsmanager_version" {
  description = "The unique identifier of the version of the secret."
  value       = var.create_secretmanager_secret ? aws_secretsmanager_secret_version.password_val.version_id : ""
}

output "password_ssm_arn" {
  description = "The ARN of the SecretManager Secret."
  value       = var.create_ssm_secret ? aws_ssm_parameter.password.arn : ""
}

output "password_ssm_name" {
  description = "The name of the parameter."
  value       = var.create_ssm_secret ? aws_ssm_parameter.password.name : ""
}

output "password_ssm_version" {
  description = "The unique identifier of the version of the secret."
  value       = var.create_ssm_secret ? aws_ssm_parameter.password.version : ""
}

output "username" {
  description = "The master username for the database."
  value       = aws_db_instance.this.username
}
