
locals {
  db_instance = var.ignore_engine_version_and_password_changes ? aws_db_instance.this_ignore[0] : aws_db_instance.this[0]
}
output "address" {
  description = "RDS database address"
  value       = local.db_instance.address
}

output "instance_connection_info" {
  description = "Object containing connection info"
  value = {
    address  = local.db_instance.address
    endpoint = local.db_instance.endpoint
    id       = local.db_instance.id
    port     = local.db_instance.port
    username = local.db_instance.username
  }
}

output "instance_id" {
  description = "Instance ID of RDS DB"
  value       = local.db_instance.id
}

output "password_secretsmanager_arn" {
  description = "The ARN of the SecretManager Secret."
  value       = try(module.password.secret_arn, null)
}

output "password_secretsmanager_version" {
  description = "The unique identifier of the version of the secret."
  value       = try(module.password.version_id, null)
}

output "master_user_secret" {
  description = "The master user secret when using RDS managed password"
  value = local.use_managed_master_user_secret ? {
    secret_arn    = try(local.db_instance.master_user_secret[0].secret_arn, null)
    secret_status = try(local.db_instance.master_user_secret[0].secret_status, null)
    kms_key_id    = try(local.db_instance.master_user_secret[0].kms_key_id, null)
  } : null
}


output "username" {
  description = "The master username for the database."
  value       = var.username
}
