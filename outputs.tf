output "address" {
  description = "RDS database address"
  value       = aws_db_instance.this.address
}

output "instance_connection_info" {
  description = "Object containing connection info"
  value = {
    address  = aws_db_instance.this.address
    endpoint = aws_db_instance.this.endpoint
    id       = aws_db_instance.this.id
    port     = aws_db_instance.this.port
    username = aws_db_instance.this.username
  }
}

output "instance_id" {
  description = "Instance ID of RDS DB"
  value       = aws_db_instance.this.id
}

output "password_secretsmanager_arn" {
  description = "The ARN of the SecretManager Secret."
  value       = try(module.password.secret_arn, null)
}

output "password_secretsmanager_version" {
  description = "The unique identifier of the version of the secret."
  value       = try(module.password.version_id, null)
}

output "password_ssm_parameter_arn" {
  description = "The ARN of the SecretManager Secret."
  value       = try(aws_ssm_parameter.password[0].arn, null)
}

output "password_ssm_parameter_name" {
  description = "The name of the parameter."
  value       = try(aws_ssm_parameter.password[0].name, null)
}

output "password_ssm_parameter_version" {
  description = "The unique identifier of the version of the secret."
  value       = try(aws_ssm_parameter.password[0].version, null)
}

output "username" {
  description = "The master username for the database."
  value       = var.username
}
