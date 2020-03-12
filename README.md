# terraform-aws-rds-postgres
[![](https://github.com/rhythmictech/terraform-aws-rds-postgres/workflows/check/badge.svg)](https://github.com/rhythmictech/terraform-aws-rds-postgres/actions)

Create a Postgres RDS instance



<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allowed\_cidr\_blocks | CIDR blocks allowed to reach the database | list(string) | `[]` | no |
| allowed\_ipv6\_cidr\_blocks | IPv6 CIDR blocks allowed to reach the database | list(string) | `[]` | no |
| allowed\_password\_chars | What characters are allowed in the postgres password | string | `"!#%^\u0026*()-_=+[]{}\u003c\u003e?"` | no |
| allowed\_security\_groups | IDs of security groups allowed to reach the database \(not Names\) | list(string) | `[]` | no |
| backup\_retention\_period | How long to keep RDS backups \(in days\) | string | `"5"` | no |
| db\_name | database name \(leave blank to keep RDS from creating an initial database\) | string | `""` | no |
| engine\_version | Version of database engine to use | string | `"11.5"` | no |
| iam\_database\_authentication |  | bool | `"false"` | no |
| identifier\_prefix | what to prefix the rds url with | string | `"postgres-rds"` | no |
| instance\_class | What instance size to use | string | `"db.t3.small"` | no |
| multi\_az | whether to make database multi-az | string | `"false"` | no |
| name | common name for resources in this module | string | n/a | yes |
| pass\_version | Increment to force DB password change | string | `"1"` | no |
| port | Port the database should listen on | string | `"5432"` | no |
| skip\_final\_snapshot | If true no final snapshot will be taken on termination | string | `"false"` | no |
| storage | How much storage is available to the database | string | n/a | yes |
| storage\_encrypted | Use EBS volume encryption \(AWS-SSE\) | bool | `"true"` | no |
| storage\_type | What storage backend to use \(gp2 or standard. io1 not supported\) | string | `"gp2"` | no |
| subnet\_group\_name | Subnet group used for database | string | n/a | yes |
| tags | common tags for all resources | map(string) | `{}` | no |
| username | username of master user | string | `"postgres_user"` | no |
| vpc\_id | ID of VPC resources will be created in | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance |  |
| password-arn |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
