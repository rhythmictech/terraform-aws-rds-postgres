# terraform-aws-rds-postgres
[![tflint](https://github.com/rhythmictech/terraform-aws-rds-postgres/workflows/tflint/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-rds-postgres/actions?query=workflow%3Atflint+event%3Apush+branch%3Amaster)
[![tfsec](https://github.com/rhythmictech/terraform-aws-rds-postgres/workflows/tfsec/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-rds-postgres/actions?query=workflow%3Atfsec+event%3Apush+branch%3Amaster)
[![yamllint](https://github.com/rhythmictech/terraform-aws-rds-postgres/workflows/yamllint/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-rds-postgres/actions?query=workflow%3Ayamllint+event%3Apush+branch%3Amaster)
[![misspell](https://github.com/rhythmictech/terraform-aws-rds-postgres/workflows/misspell/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-rds-postgres/actions?query=workflow%3Amisspell+event%3Apush+branch%3Amaster)
[![pre-commit-check](https://github.com/rhythmictech/terraform-aws-rds-postgres/workflows/pre-commit-check/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-rds-postgres/actions?query=workflow%3Apre-commit-check+event%3Apush+branch%3Amaster)
<a href="https://twitter.com/intent/follow?screen_name=RhythmicTech"><img src="https://img.shields.io/twitter/follow/RhythmicTech?style=social&logo=twitter" alt="follow on Twitter"></a>

Create and manage an RDS PostgreSQL instance. Includes the ability to manage the master password in Secrets Manager or SSM and manage the security group that controls RDS access.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.19 |
| aws | ~> 2.69.0 |
| random | >= 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.69.0 |
| random | >= 2.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| instance\_class | What instance type to use | `string` | n/a | yes |
| subnet\_group\_name | name of DB subnet group to place DB in | `string` | n/a | yes |
| vpc\_id | ID of VPC resources will be created in | `string` | n/a | yes |
| allowed\_cidr\_blocks | CIDR blocks allowed to reach the database | `list(string)` | `[]` | no |
| allowed\_ipv6\_cidr\_blocks | IPv6 CIDR blocks allowed to reach the database | `list(string)` | `[]` | no |
| allowed\_security\_groups | IDs of security groups allowed to reach the database (not Names) | `list(string)` | `[]` | no |
| backup\_retention\_period | How long to keep RDS backups (in days) | `string` | `5` | no |
| cloudwatch\_log\_exports | Log types to export to CloudWatch | `list(string)` | <pre>[<br>  "postgresql",<br>  "upgrade"<br>]</pre> | no |
| create\_secretmanager\_secret | True to create a secretmanager secret containing DB password (not used if `password` is set) | `bool` | `true` | no |
| create\_ssm\_secret | True to create a SSM Parameter SecretString containing DB password (not used if `password` is set) | `bool` | `false` | no |
| enable\_deletion\_protection | If `true`, deletion protection will be turned on for the RDS instance(s) | `bool` | `true` | no |
| engine\_version | Version of database engine to use | `string` | `"11.5"` | no |
| final\_snapshot\_identifier | name of final snapshot (will be computed automatically if not specified) | `string` | `null` | no |
| iam\_database\_authentication\_enabled | True to enable IAM DB authentication | `bool` | `false` | no |
| identifier | DB identifier (not recommended, only used if `identifier_prefix` is not null) | `string` | `null` | no |
| identifier\_prefix | DB identifier prefix (will be generated by AWS automatically if not specified) | `string` | `null` | no |
| monitoring\_interval | Monitoring interval in seconds (`0` to disable enhanced monitoring) | `number` | `0` | no |
| monitoring\_role\_arn | Enhanced Monitoring ARN (if `monitoring_interval > 0` and this is omitted, a role will be created automatically) | `string` | `null` | no |
| multi\_az | whether to make database multi-az | `bool` | `true` | no |
| name | common name for resources in this module | `string` | `"mysql-postgres"` | no |
| parameters | Database parameters (will create parameter group if not null) | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | <pre>[<br>  {<br>    "name": "client_encoding",<br>    "value": "UTF8"<br>  }<br>]</pre> | no |
| pass\_version | Increment to force master user password change (not used if `password` is set) | `number` | `1` | no |
| password | Master password (if not set, one will be generated dynamically) | `string` | `null` | no |
| password\_length | Master password length (not used if `password` is set) | `number` | `30` | no |
| performance\_insights\_enabled | If true, performance insights will be enabled | `bool` | `false` | no |
| port | Port the database should listen on | `number` | `5432` | no |
| skip\_final\_snapshot | If true no final snapshot will be taken on termination | `bool` | `false` | no |
| ssm\_path | Custom path for SSM parameter, only takes effect if `create_ssm_secret` is true. | `string` | `""` | no |
| storage | How much storage is available to the database | `string` | `20` | no |
| storage\_encrypted | Encrypt DB storage | `bool` | `true` | no |
| storage\_type | What storage backend to use (`gp2` or `standard`. io1 not supported) | `string` | `"gp2"` | no |
| tags | Tags to apply to supported resources | `map(string)` | `{}` | no |
| username | Username of master user | `string` | `"postgres"` | no |

## Outputs

| Name | Description |
|------|-------------|
| address | RDS database address |
| instance\_connection\_info | Object containing connection info |
| instance\_id | Instance ID of RDS DB |
| password\_secretsmanager\_arn | The ARN of the SecretManager Secret. |
| password\_secretsmanager\_version | The unique identifier of the version of the secret. |
| password\_ssm\_parameter\_arn | The ARN of the SecretManager Secret. |
| password\_ssm\_parameter\_name | The name of the parameter. |
| password\_ssm\_parameter\_version | The unique identifier of the version of the secret. |
| username | The master username for the database. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
