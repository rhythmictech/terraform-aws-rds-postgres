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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.19 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.69 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.56.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_password"></a> [password](#module\_password) | rhythmictech/secretsmanager-random-secret/aws | ~>1.2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_instance.this_ignore](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_ipv4_cidrs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_ipv6_cidrs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | CIDR blocks allowed to reach the database | `list(string)` | `[]` | no |
| <a name="input_allowed_ipv6_cidr_blocks"></a> [allowed\_ipv6\_cidr\_blocks](#input\_allowed\_ipv6\_cidr\_blocks) | IPv6 CIDR blocks allowed to reach the database | `list(string)` | `[]` | no |
| <a name="input_allowed_security_groups"></a> [allowed\_security\_groups](#input\_allowed\_security\_groups) | IDs of security groups allowed to reach the database (not Names) | `list(string)` | `[]` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | How long to keep RDS backups (in days) | `string` | `5` | no |
| <a name="input_cloudwatch_log_exports"></a> [cloudwatch\_log\_exports](#input\_cloudwatch\_log\_exports) | Log types to export to CloudWatch | `list(string)` | <pre>[<br>  "postgresql",<br>  "upgrade"<br>]</pre> | no |
| <a name="input_create_secretmanager_secret"></a> [create\_secretmanager\_secret](#input\_create\_secretmanager\_secret) | True to create a secretmanager secret containing DB password (not used if `password` is set) | `bool` | `true` | no |
| <a name="input_create_ssm_secret"></a> [create\_ssm\_secret](#input\_create\_ssm\_secret) | True to create a SSM Parameter SecretString containing DB password (not used if `password` is set) | `bool` | `false` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Name of the initial database to create. (null for none) | `string` | `null` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | If `true`, deletion protection will be turned on for the RDS instance(s) | `bool` | `true` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Version of database engine to use | `string` | `"11.5"` | no |
| <a name="input_final_snapshot_identifier"></a> [final\_snapshot\_identifier](#input\_final\_snapshot\_identifier) | name of final snapshot (will be computed automatically if not specified) | `string` | `null` | no |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | True to enable IAM DB authentication | `bool` | `false` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | DB identifier (not recommended, only used if `identifier_prefix` is not null) | `string` | `null` | no |
| <a name="input_identifier_prefix"></a> [identifier\_prefix](#input\_identifier\_prefix) | DB identifier prefix (will be generated by AWS automatically if not specified) | `string` | `null` | no |
| <a name="input_ignore_engine_version_and_password_changes"></a> [ignore\_engine\_version\_and\_password\_changes](#input\_ignore\_engine\_version\_and\_password\_changes) | Ignore changes to the `var.engine_version` and the db `password` that might be caused by automatic upgrades | `bool` | `true` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | What instance type to use | `string` | n/a | yes |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | Monitoring interval in seconds (`0` to disable enhanced monitoring) | `number` | `0` | no |
| <a name="input_monitoring_role_arn"></a> [monitoring\_role\_arn](#input\_monitoring\_role\_arn) | Enhanced Monitoring ARN (if `monitoring_interval > 0` and this is omitted, a role will be created automatically) | `string` | `null` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | whether to make database multi-az | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | common name for resources in this module | `string` | `"mysql-postgres"` | no |
| <a name="input_parameter_group_family"></a> [parameter\_group\_family](#input\_parameter\_group\_family) | Parameter Group Family. Need to make explicit for Postgres 9.x | `string` | `""` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | Database parameters (will create parameter group if not null) | <pre>list(object({<br>    apply_method = string<br>    name         = string<br>    value        = string<br>  }))</pre> | <pre>[<br>  {<br>    "apply_method": "immediate",<br>    "name": "client_encoding",<br>    "value": "UTF8"<br>  }<br>]</pre> | no |
| <a name="input_pass_version"></a> [pass\_version](#input\_pass\_version) | Increment to force master user password change (not used if `password` is set) | `number` | `1` | no |
| <a name="input_password"></a> [password](#input\_password) | Master password (if not set, one will be generated dynamically) | `string` | `null` | no |
| <a name="input_password_length"></a> [password\_length](#input\_password\_length) | Master password length (not used if `password` is set) | `number` | `30` | no |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | If true, performance insights will be enabled | `bool` | `false` | no |
| <a name="input_port"></a> [port](#input\_port) | Port the database should listen on | `number` | `5432` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | If true no final snapshot will be taken on termination | `bool` | `false` | no |
| <a name="input_ssm_path"></a> [ssm\_path](#input\_ssm\_path) | Custom path for SSM parameter, only takes effect if `create_ssm_secret` is true. | `string` | `""` | no |
| <a name="input_storage"></a> [storage](#input\_storage) | How much storage is available to the database | `string` | `20` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Encrypt DB storage | `bool` | `true` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | What storage backend to use (`gp2` or `standard`. io1 not supported) | `string` | `"gp2"` | no |
| <a name="input_subnet_group_name"></a> [subnet\_group\_name](#input\_subnet\_group\_name) | name of DB subnet group to place DB in | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to supported resources | `map(string)` | `{}` | no |
| <a name="input_username"></a> [username](#input\_username) | Username of master user | `string` | `"postgres"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of VPC resources will be created in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address"></a> [address](#output\_address) | RDS database address |
| <a name="output_instance_connection_info"></a> [instance\_connection\_info](#output\_instance\_connection\_info) | Object containing connection info |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | Instance ID of RDS DB |
| <a name="output_password_secretsmanager_arn"></a> [password\_secretsmanager\_arn](#output\_password\_secretsmanager\_arn) | The ARN of the SecretManager Secret. |
| <a name="output_password_secretsmanager_version"></a> [password\_secretsmanager\_version](#output\_password\_secretsmanager\_version) | The unique identifier of the version of the secret. |
| <a name="output_password_ssm_parameter_arn"></a> [password\_ssm\_parameter\_arn](#output\_password\_ssm\_parameter\_arn) | The ARN of the SecretManager Secret. |
| <a name="output_password_ssm_parameter_name"></a> [password\_ssm\_parameter\_name](#output\_password\_ssm\_parameter\_name) | The name of the parameter. |
| <a name="output_password_ssm_parameter_version"></a> [password\_ssm\_parameter\_version](#output\_password\_ssm\_parameter\_version) | The unique identifier of the version of the secret. |
| <a name="output_username"></a> [username](#output\_username) | The master username for the database. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
