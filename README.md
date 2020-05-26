# terraform-aws-rds-mysql
Create a mysql RDS instance

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| random | >= 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | >= 2.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_cidr\_blocks | CIDR blocks allowed to reach the database | `list(string)` | `[]` | no |
| allowed\_ipv6\_cidr\_blocks | IPv6 CIDR blocks allowed to reach the database | `list(string)` | `[]` | no |
| allowed\_password\_chars | What characters are allowed in the postgres password | `string` | `"!#%^\u0026*()-_=+[]{}\u003c\u003e?"` | no |
| allowed\_security\_groups | IDs of security groups allowed to reach the database (not Names) | `list(string)` | `[]` | no |
| backup\_retention\_period | How long to keep RDS backups (in days) | `string` | `5` | no |
| engine | Which RDS Engine to use | `string` | `"postgres"` | no |
| engine\_version | Version of database engine to use | `string` | `"11.5"` | no |
| instance\_class | What instance size to use | `string` | `"db.t3.small"` | no |
| multi\_az | whether to make database multi-az | `string` | `true` | no |
| name | common name for resources in this module | `string` | `"postgres-rds"` | no |
| pass\_version | Increment to force DB password change | `string` | `1` | no |
| port | Port the database should listen on | `string` | `"5432"` | no |
| skip\_final\_snapshot | If true no final snapshot will be taken on termination | `string` | `false` | no |
| storage | How much storage is available to the database | `string` | `20` | no |
| storage\_type | What storage backend to use (gp2 or standard. io1 not supported) | `string` | `"gp2"` | no |
| subnet\_ids | Subnets used for database | `list(string)` | n/a | yes |
| tags | common tags for all resources | `map(string)` | `{}` | no |
| username | username of master user | `string` | `"postgres_user"` | no |
| vpc\_id | ID of VPC resources will be created in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| address | n/a |
| instance | n/a |
| instance-id | n/a |
| password-arn | n/a |
| password-version | n/a |
| username | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
