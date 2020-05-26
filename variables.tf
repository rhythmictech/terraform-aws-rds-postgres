variable "allowed_cidr_blocks" {
  default     = []
  description = "CIDR blocks allowed to reach the database"
  type        = list(string)
}

variable "allowed_ipv6_cidr_blocks" {
  default     = []
  description = "IPv6 CIDR blocks allowed to reach the database"
  type        = list(string)
}

variable "allowed_password_chars" {
  default     = "!#%^&*()-_=+[]{}<>?"
  description = "What characters are allowed in the postgres password"
  type        = string
}

variable "allowed_security_groups" {
  default     = []
  description = "IDs of security groups allowed to reach the database (not Names)"
  type        = list(string)
}

variable "backup_retention_period" {
  default     = 5
  description = "How long to keep RDS backups (in days)"
  type        = string
}

variable "engine" {
  default     = "postgres"
  description = "Which RDS Engine to use"
  type        = string
}

variable "engine_version" {
  default     = "11.5"
  description = "Version of database engine to use"
  type        = string
}

variable "instance_class" {
  default     = "db.t3.small"
  description = "What instance size to use"
  type        = string
}

variable "multi_az" {
  default     = true
  description = "whether to make database multi-az"
  type        = string
}

variable "name" {
  default     = "postgres-rds"
  description = "common name for resources in this module"
  type        = string
}

variable "pass_version" {
  default     = 1
  description = "Increment to force DB password change"
  type        = string
}

variable "port" {
  default     = "5432"
  description = "Port the database should listen on"
  type        = string
}

variable "skip_final_snapshot" {
  default     = false
  description = "If true no final snapshot will be taken on termination"
  type        = string
}

variable "storage" {
  default     = 20
  description = "How much storage is available to the database"
  type        = string
}

variable "storage_type" {
  default     = "gp2"
  description = "What storage backend to use (gp2 or standard. io1 not supported)"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets used for database"
  type        = list(string)
}

variable "tags" {
  default     = {}
  description = "common tags for all resources"
  type        = map(string)
}

variable "username" {
  default     = "postgres_user"
  description = "username of master user"
  type        = string
}

variable "vpc_id" {
  description = "ID of VPC resources will be created in"
  type        = string
}

##################################################
# Global Vars
##################################################
variable "env" {
  description = "Environment being deployed to"
  type        = string
}

variable "namespace" {
  description = "Namespace of this project/system"
  type        = string
}

variable "owner" {
  description = "Team/person responsible for resources defined within this project"
  type        = string
}

variable "region" {
  description = "Region resources are being deployed to"
  type        = string
}
