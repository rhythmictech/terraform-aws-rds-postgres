output "password-arn" {
  value = module.db-password.secret_arn
}


output "instance" {
  value = {
    id       = aws_db_instance.this.id
    username = aws_db_instance.this.username
    address  = aws_db_instance.this.address
    port     = aws_db_instance.this.port
    endpoint = aws_db_instance.this.endpoint
  }
}
