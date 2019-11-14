variable "name" {
  description = "common name for resources in this module"
  type        = string
  default     = "postgres-rds"
}

variable "tags" {
  type        = map(string)
  description = "common tags for all resources"
  default     = {}
}

variable "subnet_ids" {
  description = "Subnets used for database"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of VPC resources will be created in"
  type        = string
}

variable "allowed_security_groups" {
  description = "IDs of security groups allowed to reach the database (not Names)"
  type        = list(string)
  default     = []
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to reach the database"
  type        = list(string)
  default     = []
}

variable "allowed_ipv6_cidr_blocks" {
  description = "IPv6 CIDR blocks allowed to reach the database"
  type        = list(string)
  default     = []
}

variable "storage" {
  description = "How much storage is available to the database"
  type        = string
  default     = 20
}

variable "storage_type" {
  description = "What storage backend to use (gp2 or standard. io1 not supported)"
  type        = string
  default     = "gp2"
}

variable "engine" {
  description = "Which RDS Engine to use"
  type        = "string"
  default     = "postgres"
}

variable "engine_version" {
  description = "Version of database engine to use"
  type        = string
  default     = "11.5"
}

variable "instance_class" {
  description = "What instance size to use"
  type        = string
  default     = "db.t3.small"
}

variable "multi_az" {
  description = "whether to make database multi-az"
  type        = string
  default     = true
}

variable "username" {
  description = "username of master user"
  type        = string
  default     = "postgres_user"
}

variable "backup_retention_period" {
  description = "How long to keep RDS backups (in days)"
  type        = string
  default     = 5
}

variable "port" {
  description = "Port the database should listen on"
  type        = string
  default     = "5432"
}

variable "skip_final_snapshot" {
  description = "If true no final snapshot will be taken on termination"
  type        = string
  default     = false
}

variable "pass_version" {
  description = "Increment to force DB password change"
  type        = string
  default     = 1
}

variable "allowed_password_chars" {
  description = "What characters are allowed in the postgres password"
  type        = string
  default     = "!#%^&*()-_=+[]{}<>?"
}
