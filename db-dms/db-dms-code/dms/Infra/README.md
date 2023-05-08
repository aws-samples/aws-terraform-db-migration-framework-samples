# Base Infrastructure for DMS

Here we are going to create AWS resources those are common for all DMS replication :

    A. Create Default DMS roles if not done 
    B. Create DMS Subnet or if exists provide the name 
    C. Create number of DMS Replication instances as per the project requirment.
    D. Create Cloudwatch Alarts for the DMS Replication instances
    E. Create Source and Source and Traget Endpoints (Detais below)

## DMS Roles 
---

Database Migration Service requires the below IAM Roles to be created before replication instances can be created. 
See the [DMS Documentation](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Security.html#CHAP_Security.APIRole) for additional information.

 * dms-vpc-role
 * dms-cloudwatch-logs-role
 * dms-access-for-endpoint

## DMS Subnet Group
---

This create DMS subnet group based on given subnet ids. Based on your Oraganization security and network deployment you need to provide public or private subnets.

## DMS Replication Instance
---

Based on value of `ri_count`, those many replication instances will be created with same configuration. 

## DMS Replication Monitoring
---
This create below Cloudwatch Alarm for each Replication instance :

*  CPU Utilization 
*  Freeable Memory 
*  Swap Utilization 
  
We also create a Metric Filter based Cloudwatch Alarm which mointor all the task logs associated with the replication instance and notify if there is any error `"E:"` detected in the DMS replication tasks for which Cloudwtach logging enabled. 

This script create a Cloudwatch log group for each replication instance with configurable retention period. 

## Source database DMS Endpoint
---

Considering Security best parctice, we recommentd you to keep all database details in a AWS secret manager and provide the secret name as the input to this terraform project. This way you can avoid hard coding sensetive database details in the `.tfvar` file. 

If you can not create AWS secret, you have option to provide input for each field.

### SSL Configuration 
---

AWS DMS support SSL ([link](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Security.html#CHAP_Security.SSL)). You need to add the certificate (.pem/.sso) files in the `Certificates` directort and rfer them in the `aws_dms_certificate` resource creation.

### Secret Manager Template 
---

Based on engine type the secret string json structure as below :

```json
{
      "engine"   : "<<Database engine name like 'oracle', 'postgresql'>>"
    , "username" : "<<Database user name>>"
    , "password" : "<<Database user Password>>"
    , "db_name"  : "<<Database Name to connect>>"
    , "db_port"  : 9999
    , "db_host"  : "<<some.db.domain.com>>"
}
```

If Oracle database using ASM to store archive logfiles, you need to provide details for the ASM instance. To increase security you can store all required valuse in a AWS Secret and provide the secret name. The JSON format of the secter string need to be below format. You have option to provide these details as individual field in `input.tfvar` file also. 

```json
{
      "username" : "<<ASM user name>>"
    , "password" : "<<ASM user Password>>"
    , "db_name"  : "+ASM"
    , "db_port"  : 9999
    , "db_host"  : "<<IP address of the ASM Instance>>"
}
```


### Source Endpoint for Oracle database
---

AWS DMS provide many extra connection attributes (ECA) when Oracle as source database for DMS. These ECA are applicatble for specific conditions. This project automatically add ECA for below features :

* `Log Miner` and `Binary Reader`
* Oracle ASM  
* Source is RDS for Oracle
* Source is Read replica / Oracle Active dataguard.

You need to provide other ECA as applicable for your use case.

Also this script creates both `Log Miner` and `Binary Reader` endpoint for source Oracle endpoint. Based on use case you can you the requied endpoint. 

### Source Endpoint for Non Oracle Databases
---

There is no engine specific implementation done for non-Oracle databases.


## Target database DMS Endpoint
---

Considering Security best parctice, we recommentd you to keep all database details in a AWS secret manager and provide the secret name as the input to this terraform project. This way you can avoid hard coding sensetive database details in the `.tfvar` file. 
If you can not create AWS secret, you have option to provide input for each field.

### SSL Configuration 
---

AWS DMS support SSL ([link](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Security.html#CHAP_Security.SSL)). You need to add the certificate (.pem/.sso) files in the `Certificates` directort and rfer them in the `aws_dms_certificate` resource creation.

### Secret Manager Template 
---

Based on engine type the secret string json structure as below :

```json
{
      "engine"   : "<<Database engine name like 'oracle', 'postgresql'>>"
    , "username" : "<<Database user name>>"
    , "password" : "<<Database user Password>>"
    , "db_name"  : "<<Database Name to connect>>"
    , "db_port"  : 9999
    , "db_host"  : "<<some.db.domain.com>>"
}
```

There is no engine specific automation done for DMS Target Endpoint.

---

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.22 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.70.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dms_ri_monitor"></a> [dms\_ri\_monitor](#module\_dms\_ri\_monitor) | ../Monitor/replicationInstance | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_dms_certificate.src_certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_certificate) | resource |
| [aws_dms_certificate.tgt_certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_certificate) | resource |
| [aws_dms_endpoint.src_db_ep](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint) | resource |
| [aws_dms_endpoint.src_ora_db_br_ep](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint) | resource |
| [aws_dms_endpoint.src_ora_db_lm_ep](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint) | resource |
| [aws_dms_endpoint.tgt_db_ep](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint) | resource |
| [aws_dms_replication_instance.rep_inst](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_instance) | resource |
| [aws_dms_replication_subnet_group.dms_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_subnet_group) | resource |
| [aws_iam_role.dms-access-for-endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.dms-cloudwatch-logs-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.dms-vpc-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.dms-access-for-endpoint-AmazonDMSRedshiftS3Role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.dms-cloudwatch-logs-role-AmazonDMSCloudWatchLogsRole](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.dms-vpc-role-AmazonDMSVPCManagementRole](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.dms_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_key.ri_kms_arn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_kms_key.src_kms_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_kms_key.tgt_kms_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_secretsmanager_secret_version.asm_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_secretsmanager_secret_version.src_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_secretsmanager_secret_version.tgt_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_sns_topic.dms_sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/sns_topic) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_CW_CustomNameSpace"></a> [CW\_CustomNameSpace](#input\_CW\_CustomNameSpace) | Cloudwatch Custom NameSpace to Publish Metric | `string` | `"CustomMetrics/DMS"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Region for the VPC | `string` | `"eu-west-1"` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | A mapping of tags to assign to the resource | `map(string)` | `null` | no |
| <a name="input_create_default_dms_roles"></a> [create\_default\_dms\_roles](#input\_create\_default\_dms\_roles) | whether to create default DMS roles | `bool` | `false` | no |
| <a name="input_create_dms_subnet_group"></a> [create\_dms\_subnet\_group](#input\_create\_dms\_subnet\_group) | whether to create new subnet group for DMS replication instance | `bool` | `true` | no |
| <a name="input_create_src_dms_certificate"></a> [create\_src\_dms\_certificate](#input\_create\_src\_dms\_certificate) | Whether to create Certificate (For SSL) of the Source endpoint connection | `bool` | `false` | no |
| <a name="input_create_tgt_dms_certificate"></a> [create\_tgt\_dms\_certificate](#input\_create\_tgt\_dms\_certificate) | Whether to create Certificate (For SSL) of the Target endpoint connection | `bool` | `false` | no |
| <a name="input_dms_subnet_group_id"></a> [dms\_subnet\_group\_id](#input\_dms\_subnet\_group\_id) | DMS Subnet group id for replication instance | `string` | `"default-dms-subnet-group"` | no |
| <a name="input_dms_subnet_ids"></a> [dms\_subnet\_ids](#input\_dms\_subnet\_ids) | VPC Subnet group ids, those will be part of DMS Subnet Group | `list(any)` | `[]` | no |
| <a name="input_is_tde_enabled"></a> [is\_tde\_enabled](#input\_is\_tde\_enabled) | Is the source Oracle database has TDE enabled tablespace/column? | `bool` | `false` | no |
| <a name="input_oracle_asm_host"></a> [oracle\_asm\_host](#input\_oracle\_asm\_host) | Oracle ASM host name/IP | `string` | `""` | no |
| <a name="input_oracle_asm_port"></a> [oracle\_asm\_port](#input\_oracle\_asm\_port) | Oracle ASM Port | `number` | `1521` | no |
| <a name="input_oracle_asm_pwd"></a> [oracle\_asm\_pwd](#input\_oracle\_asm\_pwd) | Oracle ASM Password | `string` | `""` | no |
| <a name="input_oracle_asm_secret"></a> [oracle\_asm\_secret](#input\_oracle\_asm\_secret) | Secret name for the Oracle ASM secret | `string` | `""` | no |
| <a name="input_oracle_asm_sid"></a> [oracle\_asm\_sid](#input\_oracle\_asm\_sid) | Oracle ASM SID | `string` | `"+ASM"` | no |
| <a name="input_oracle_asm_user"></a> [oracle\_asm\_user](#input\_oracle\_asm\_user) | Oracle ASM username | `string` | `""` | no |
| <a name="input_oracle_db_version"></a> [oracle\_db\_version](#input\_oracle\_db\_version) | Source Oracle database version | `string` | `"19"` | no |
| <a name="input_ri-mapping"></a> [ri-mapping](#input\_ri-mapping) | n/a | `list(any)` | <pre>[<br>  "2",<br>  "1",<br>  "2"<br>]</pre> | no |
| <a name="input_ri_allocated_storage"></a> [ri\_allocated\_storage](#input\_ri\_allocated\_storage) | Replication instance storage size in GB | `number` | `100` | no |
| <a name="input_ri_availability_zone"></a> [ri\_availability\_zone](#input\_ri\_availability\_zone) | AZ for replication instance | `string` | `null` | no |
| <a name="input_ri_count"></a> [ri\_count](#input\_ri\_count) | Number of replication instance to use | `number` | `2` | no |
| <a name="input_ri_cw_logs_retentions"></a> [ri\_cw\_logs\_retentions](#input\_ri\_cw\_logs\_retentions) | Cloudwatch Log Group retention for the Replication Instance | `number` | `7` | no |
| <a name="input_ri_engine_version"></a> [ri\_engine\_version](#input\_ri\_engine\_version) | Replication engine version | `string` | `"3.1.3"` | no |
| <a name="input_ri_instance_class"></a> [ri\_instance\_class](#input\_ri\_instance\_class) | Type of the ec2 instance used for replication instance | `string` | `"dms.t3.large"` | no |
| <a name="input_ri_kms_arn"></a> [ri\_kms\_alias](#input\_ri\_kms\_alias) | KMS key ARN that will be used to encrypt the connection | `string` | `"aws/dms"` | no |
| <a name="input_ri_monitoring_sns_topic"></a> [ri\_monitoring\_sns\_topic](#input\_ri\_monitoring\_sns\_topic) | SNS Topic to be used for DMS Replication Instance monitoring | `string` | `""` | no |
| <a name="input_ri_multi_az"></a> [ri\_multi\_az](#input\_ri\_multi\_az) | whether to enable multi AZ for replication instance | `bool` | `false` | no |
| <a name="input_ri_preferred_maintenance_window"></a> [ri\_preferred\_maintenance\_window](#input\_ri\_preferred\_maintenance\_window) | AZ for replication instance | `string` | `"sun:10:30-sun:14:30"` | no |
| <a name="input_ri_prefix"></a> [ri\_prefix](#input\_ri\_prefix) | Replication Instance name prefix | `string` | n/a | yes |
| <a name="input_ri_publicly_accessible"></a> [ri\_publicly\_accessible](#input\_ri\_publicly\_accessible) | whether to enable publicly accessible for replication instance | `bool` | `false` | no |
| <a name="input_ri_vpc_security_group_ids"></a> [ri\_vpc\_security\_group\_ids](#input\_ri\_vpc\_security\_group\_ids) | Replication instance security group ids | `list(any)` | n/a | yes |
| <a name="input_src_db_engine"></a> [src\_db\_engine](#input\_src\_db\_engine) | Source DB engine type | `string` | n/a | yes |
| <a name="input_src_db_host"></a> [src\_db\_host](#input\_src\_db\_host) | Source DB Host endpoint id | `string` | `""` | no |
| <a name="input_src_db_name"></a> [src\_db\_name](#input\_src\_db\_name) | Source DB names | `string` | `""` | no |
| <a name="input_src_db_port"></a> [src\_db\_port](#input\_src\_db\_port) | Source DB port | `number` | `1521` | no |
| <a name="input_src_db_pwd"></a> [src\_db\_pwd](#input\_src\_db\_pwd) | DMS Source Endpoint User password. Recommended to use srcDBhost\_secret | `string` | `""` | no |
| <a name="input_src_db_secret"></a> [src\_db\_secret](#input\_src\_db\_secret) | Secret name for the Source DB | `string` | `""` | no |
| <a name="input_src_db_user"></a> [src\_db\_user](#input\_src\_db\_user) | DMS Source Endpoint User name. Recommended to use srcDBhost\_secret | `string` | `""` | no |
| <a name="input_src_dms_certificate_arn"></a> [src\_dms\_certificate\_arn](#input\_src\_dms\_certificate\_arn) | Certificate ARN (For SSL) of the Source endpoint connection | `string` | `""` | no |
| <a name="input_src_dms_certificate_name"></a> [src\_dms\_certificate\_name](#input\_src\_dms\_certificate\_name) | Certificate Name (For SSL) of the Source endpoint connection to be created | `string` | `"dms-source-ep-certificate"` | no |
| <a name="input_src_ep_prefix"></a> [src\_ep\_prefix](#input\_src\_ep\_prefix) | DMS endpoint prefix for the Source DB | `string` | `""` | no |
| <a name="input_src_extra_connection_attributes"></a> [src\_extra\_connection\_attributes](#input\_src\_extra\_connection\_attributes) | DMS Extra connection attributes for source endpoints | `string` | `""` | no |
| <a name="input_src_kms_alias"></a> [src\_kms\_alias](#input\_src\_kms\_alias) | KMS key alias that will be used to encrypt the endpoint | `string` | `"aws/dms"` | no |
| <a name="input_src_rds"></a> [src\_rds](#input\_src\_rds) | Is the Source DB RDS ? | `bool` | `false` | no |
| <a name="input_src_read_replica"></a> [src\_read\_replica](#input\_src\_read\_replica) | Is the Source DB read replica (Oracle Active Dataguard / RDS Read replica) ? | `bool` | `false` | no |
| <a name="input_src_ssl_mode"></a> [src\_ssl\_mode](#input\_src\_ssl\_mode) | Is the DB connection SSL Enabled ? [none require verify-ca verify-full] | `string` | `"none"` | no |
| <a name="input_tgt_db_engine"></a> [tgt\_db\_engine](#input\_tgt\_db\_engine) | Target DB engine type | `string` | n/a | yes |
| <a name="input_tgt_db_host"></a> [tgt\_db\_host](#input\_tgt\_db\_host) | Target DB Host name/IP | `string` | `""` | no |
| <a name="input_tgt_db_name"></a> [tgt\_db\_name](#input\_tgt\_db\_name) | Target DB names | `string` | `""` | no |
| <a name="input_tgt_db_port"></a> [tgt\_db\_port](#input\_tgt\_db\_port) | Target DB port | `number` | n/a | yes |
| <a name="input_tgt_db_pwd"></a> [tgt\_db\_pwd](#input\_tgt\_db\_pwd) | DMS Target Endpoint User password | `string` | `""` | no |
| <a name="input_tgt_db_secret"></a> [tgt\_db\_secret](#input\_tgt\_db\_secret) | Secret name for the Source DB | `string` | `""` | no |
| <a name="input_tgt_db_user"></a> [tgt\_db\_user](#input\_tgt\_db\_user) | DMS Target Endpoint User names | `string` | `""` | no |
| <a name="input_tgt_dms_certificate_arn"></a> [tgt\_dms\_certificate\_arn](#input\_tgt\_dms\_certificate\_arn) | Certificate ARN (For SSL) of the Target endpoint connection | `string` | `""` | no |
| <a name="input_tgt_dms_certificate_name"></a> [tgt\_dms\_certificate\_name](#input\_tgt\_dms\_certificate\_name) | Certificate Name (For SSL) of the Target endpoint connection to be created | `string` | `"dms-target-ep-certificate"` | no |
| <a name="input_tgt_ep_prefix"></a> [tgt\_ep\_prefix](#input\_tgt\_ep\_prefix) | DMS endpoint prefix for the Target DB | `string` | `""` | no |
| <a name="input_tgt_extra_connection_attributes"></a> [tgt\_extra\_connection\_attributes](#input\_tgt\_extra\_connection\_attributes) | DMS Extra connection attributes for target endpoints | `string` | `null` | no |
| <a name="input_tgt_kms_alias"></a> [tgt\_kms\_alias](#input\_tgt\_kms\_alias) | KMS key alias that will be used to encrypt the endpoint | `string` | `"aws/dms"` | no |
| <a name="input_tgt_ssl_mode"></a> [tgt\_ssl\_mode](#input\_tgt\_ssl\_mode) | Is the DB connection SSL Enabled ? [none require verify-ca verify-full] | `string` | `"none"` | no |
| <a name="input_use_cdc"></a> [use\_cdc](#input\_use\_cdc) | Is the migration required change data capture ? | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_replication_instance_arns"></a> [replication\_instance\_arns](#output\_replication\_instance\_arns) | List of Replication Instance's ARN |
| <a name="output_replication_instance_names"></a> [replication\_instance\_names](#output\_replication\_instance\_names) | List of Replication Instance's name |
| <a name="output_source_non_oracle_endpoint_arn"></a> [source\_non\_oracle\_endpoint\_arn](#output\_source\_non\_oracle\_endpoint\_arn) | ARN of the Source Endpoint for Non Oracle Target |
| <a name="output_source_non_oracle_endpoint_name"></a> [source\_non\_oracle\_endpoint\_name](#output\_source\_non\_oracle\_endpoint\_name) | Name of the Source Endpoint for Non Oracle Target |
| <a name="output_source_oracle_binaryreader_endpoint_arn"></a> [source\_oracle\_binaryreader\_endpoint\_arn](#output\_source\_oracle\_binaryreader\_endpoint\_arn) | ARN of the Source Endpoint for Oracle Binary Reader |
| <a name="output_source_oracle_binaryreader_endpoint_name"></a> [source\_oracle\_binaryreader\_endpoint\_name](#output\_source\_oracle\_binaryreader\_endpoint\_name) | Name of the Source Endpoint for Oracle Binary Reader |
| <a name="output_source_oracle_logminer_endpoint_arn"></a> [source\_oracle\_logminer\_endpoint\_arn](#output\_source\_oracle\_logminer\_endpoint\_arn) | ARN of the Source Endpoint for Oracle Logminer |
| <a name="output_source_oracle_logminer_endpoint_name"></a> [source\_oracle\_logminer\_endpoint\_name](#output\_source\_oracle\_logminer\_endpoint\_name) | Name of the Source Endpoint for Oracle Logminer |
| <a name="output_target_endpoint_arn"></a> [target\_endpoint\_arn](#output\_target\_endpoint\_arn) | Target Endpoint ARN |
| <a name="output_target_endpoint_name"></a> [target\_endpoint\_name](#output\_target\_endpoint\_name) | Target Endpoint Name |
<!--       END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.20 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.70.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dms_ri_monitor"></a> [dms\_ri\_monitor](#module\_dms\_ri\_monitor) | ../Monitor/replicationInstance | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_dms_certificate.src_certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_certificate) | resource |
| [aws_dms_certificate.tgt_certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_certificate) | resource |
| [aws_dms_endpoint.src_db_ep](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint) | resource |
| [aws_dms_endpoint.src_ora_db_br_ep](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint) | resource |
| [aws_dms_endpoint.src_ora_db_lm_ep](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint) | resource |
| [aws_dms_endpoint.tgt_db_ep](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint) | resource |
| [aws_dms_replication_instance.rep_inst](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_instance) | resource |
| [aws_dms_replication_subnet_group.dms_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_subnet_group) | resource |
| [aws_iam_role.dms-access-for-endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.dms-cloudwatch-logs-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.dms-vpc-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.dms-access-for-endpoint-AmazonDMSRedshiftS3Role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.dms-cloudwatch-logs-role-AmazonDMSCloudWatchLogsRole](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.dms-vpc-role-AmazonDMSVPCManagementRole](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.dms_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_key.ri_kms_arn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_kms_key.src_kms_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_kms_key.tgt_kms_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_secretsmanager_secret_version.asm_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_secretsmanager_secret_version.src_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_secretsmanager_secret_version.tgt_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_sns_topic.dms_sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/sns_topic) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_CW_CustomNameSpace"></a> [CW\_CustomNameSpace](#input\_CW\_CustomNameSpace) | Cloudwatch Custom NameSpace to Publish Metric | `string` | `"CustomMetrics/DMS"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Region for the VPC | `string` | `"eu-west-1"` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | A mapping of tags to assign to the resource | `map(string)` | `null` | no |
| <a name="input_create_default_dms_roles"></a> [create\_default\_dms\_roles](#input\_create\_default\_dms\_roles) | whether to create default DMS roles | `bool` | `false` | no |
| <a name="input_create_dms_subnet_group"></a> [create\_dms\_subnet\_group](#input\_create\_dms\_subnet\_group) | whether to create new subnet group for DMS replication instance | `bool` | `true` | no |
| <a name="input_create_src_dms_certificate"></a> [create\_src\_dms\_certificate](#input\_create\_src\_dms\_certificate) | Whether to create Certificate (For SSL) of the Source endpoint connection | `bool` | `false` | no |
| <a name="input_create_tgt_dms_certificate"></a> [create\_tgt\_dms\_certificate](#input\_create\_tgt\_dms\_certificate) | Whether to create Certificate (For SSL) of the Target endpoint connection | `bool` | `false` | no |
| <a name="input_dms_subnet_group_id"></a> [dms\_subnet\_group\_id](#input\_dms\_subnet\_group\_id) | DMS Subnet group id for replication instance | `string` | `"default-dms-subnet-group"` | no |
| <a name="input_dms_subnet_ids"></a> [dms\_subnet\_ids](#input\_dms\_subnet\_ids) | VPC Subnet group ids, those will be part of DMS Subnet Group | `list(any)` | `[]` | no |
| <a name="input_is_tde_enabled"></a> [is\_tde\_enabled](#input\_is\_tde\_enabled) | Is the source Oracle database has TDE enabled tablespace/column? | `bool` | `false` | no |
| <a name="input_oracle_asm_host"></a> [oracle\_asm\_host](#input\_oracle\_asm\_host) | Oracle ASM host name/IP | `string` | `""` | no |
| <a name="input_oracle_asm_port"></a> [oracle\_asm\_port](#input\_oracle\_asm\_port) | Oracle ASM Port | `number` | `1521` | no |
| <a name="input_oracle_asm_pwd"></a> [oracle\_asm\_pwd](#input\_oracle\_asm\_pwd) | Oracle ASM Password | `string` | `""` | no |
| <a name="input_oracle_asm_secret"></a> [oracle\_asm\_secret](#input\_oracle\_asm\_secret) | Secret name for the Oracle ASM secret | `string` | `""` | no |
| <a name="input_oracle_asm_sid"></a> [oracle\_asm\_sid](#input\_oracle\_asm\_sid) | Oracle ASM SID | `string` | `"+ASM"` | no |
| <a name="input_oracle_asm_user"></a> [oracle\_asm\_user](#input\_oracle\_asm\_user) | Oracle ASM username | `string` | `""` | no |
| <a name="input_oracle_db_version"></a> [oracle\_db\_version](#input\_oracle\_db\_version) | Source Oracle database version | `string` | `"19"` | no |
| <a name="input_ri-mapping"></a> [ri-mapping](#input\_ri-mapping) | n/a | `list(any)` | <pre>[<br>  "2",<br>  "1",<br>  "2"<br>]</pre> | no |
| <a name="input_ri_allocated_storage"></a> [ri\_allocated\_storage](#input\_ri\_allocated\_storage) | Replication instance storage size in GB | `number` | `100` | no |
| <a name="input_ri_availability_zone"></a> [ri\_availability\_zone](#input\_ri\_availability\_zone) | AZ for replication instance | `string` | `null` | no |
| <a name="input_ri_count"></a> [ri\_count](#input\_ri\_count) | Number of replication instance to use | `number` | `2` | no |
| <a name="input_ri_cw_logs_retentions"></a> [ri\_cw\_logs\_retentions](#input\_ri\_cw\_logs\_retentions) | Cloudwatch Log Group retention for the Replication Instance | `number` | `7` | no |
| <a name="input_ri_engine_version"></a> [ri\_engine\_version](#input\_ri\_engine\_version) | Replication engine version | `string` | `"3.1.3"` | no |
| <a name="input_ri_instance_class"></a> [ri\_instance\_class](#input\_ri\_instance\_class) | Type of the ec2 instance used for replication instance | `string` | `"dms.t3.large"` | no |
| <a name="input_ri_kms_arn"></a> [ri\_kms\_alias](#input\_ri\_kms\_alias) | KMS key ARN that will be used to encrypt the connection | `string` | `"aws/dms"` | no |
| <a name="input_ri_monitoring_sns_topic"></a> [ri\_monitoring\_sns\_topic](#input\_ri\_monitoring\_sns\_topic) | SNS Topic to be used for DMS Replication Instance monitoring | `string` | `""` | no |
| <a name="input_ri_multi_az"></a> [ri\_multi\_az](#input\_ri\_multi\_az) | whether to enable multi AZ for replication instance | `bool` | `false` | no |
| <a name="input_ri_preferred_maintenance_window"></a> [ri\_preferred\_maintenance\_window](#input\_ri\_preferred\_maintenance\_window) | AZ for replication instance | `string` | `"sun:10:30-sun:14:30"` | no |
| <a name="input_ri_prefix"></a> [ri\_prefix](#input\_ri\_prefix) | Replication Instance name prefix | `string` | n/a | yes |
| <a name="input_ri_publicly_accessible"></a> [ri\_publicly\_accessible](#input\_ri\_publicly\_accessible) | whether to enable publicly accessible for replication instance | `bool` | `false` | no |
| <a name="input_ri_vpc_security_group_ids"></a> [ri\_vpc\_security\_group\_ids](#input\_ri\_vpc\_security\_group\_ids) | Replication instance security group ids | `list(any)` | n/a | yes |
| <a name="input_src_db_engine"></a> [src\_db\_engine](#input\_src\_db\_engine) | Source DB engine type | `string` | n/a | yes |
| <a name="input_src_db_host"></a> [src\_db\_host](#input\_src\_db\_host) | Source DB Host endpoint id | `string` | `""` | no |
| <a name="input_src_db_name"></a> [src\_db\_name](#input\_src\_db\_name) | Source DB names | `string` | `""` | no |
| <a name="input_src_db_port"></a> [src\_db\_port](#input\_src\_db\_port) | Source DB port | `number` | `1521` | no |
| <a name="input_src_db_pwd"></a> [src\_db\_pwd](#input\_src\_db\_pwd) | DMS Source Endpoint User password. Recommended to use srcDBhost\_secret | `string` | `""` | no |
| <a name="input_src_db_secret"></a> [src\_db\_secret](#input\_src\_db\_secret) | Secret name for the Source DB | `string` | `""` | no |
| <a name="input_src_db_user"></a> [src\_db\_user](#input\_src\_db\_user) | DMS Source Endpoint User name. Recommended to use srcDBhost\_secret | `string` | `""` | no |
| <a name="input_src_dms_certificate_arn"></a> [src\_dms\_certificate\_arn](#input\_src\_dms\_certificate\_arn) | Certificate ARN (For SSL) of the Source endpoint connection | `string` | `""` | no |
| <a name="input_src_dms_certificate_name"></a> [src\_dms\_certificate\_name](#input\_src\_dms\_certificate\_name) | Certificate Name (For SSL) of the Source endpoint connection to be created | `string` | `"dms-source-ep-certificate"` | no |
| <a name="input_src_ep_prefix"></a> [src\_ep\_prefix](#input\_src\_ep\_prefix) | DMS endpoint prefix for the Source DB | `string` | `""` | no |
| <a name="input_src_extra_connection_attributes"></a> [src\_extra\_connection\_attributes](#input\_src\_extra\_connection\_attributes) | DMS Extra connection attributes for source endpoints | `string` | `""` | no |
| <a name="input_src_kms_alias"></a> [src\_kms\_alias](#input\_src\_kms\_alias) | KMS key alias that will be used to encrypt the endpoint | `string` | `"aws/dms"` | no |
| <a name="input_src_rds"></a> [src\_rds](#input\_src\_rds) | Is the Source DB RDS ? | `bool` | `false` | no |
| <a name="input_src_read_replica"></a> [src\_read\_replica](#input\_src\_read\_replica) | Is the Source DB read replica (Oracle Active Dataguard / RDS Read replica) ? | `bool` | `false` | no |
| <a name="input_src_ssl_mode"></a> [src\_ssl\_mode](#input\_src\_ssl\_mode) | Is the DB connection SSL Enabled ? [none require verify-ca verify-full] | `string` | `"none"` | no |
| <a name="input_tgt_db_engine"></a> [tgt\_db\_engine](#input\_tgt\_db\_engine) | Target DB engine type | `string` | n/a | yes |
| <a name="input_tgt_db_host"></a> [tgt\_db\_host](#input\_tgt\_db\_host) | Target DB Host name/IP | `string` | `""` | no |
| <a name="input_tgt_db_name"></a> [tgt\_db\_name](#input\_tgt\_db\_name) | Target DB names | `string` | `""` | no |
| <a name="input_tgt_db_port"></a> [tgt\_db\_port](#input\_tgt\_db\_port) | Target DB port | `number` | n/a | yes |
| <a name="input_tgt_db_pwd"></a> [tgt\_db\_pwd](#input\_tgt\_db\_pwd) | DMS Target Endpoint User password | `string` | `""` | no |
| <a name="input_tgt_db_secret"></a> [tgt\_db\_secret](#input\_tgt\_db\_secret) | Secret name for the Source DB | `string` | `""` | no |
| <a name="input_tgt_db_user"></a> [tgt\_db\_user](#input\_tgt\_db\_user) | DMS Target Endpoint User names | `string` | `""` | no |
| <a name="input_tgt_dms_certificate_arn"></a> [tgt\_dms\_certificate\_arn](#input\_tgt\_dms\_certificate\_arn) | Certificate ARN (For SSL) of the Target endpoint connection | `string` | `""` | no |
| <a name="input_tgt_dms_certificate_name"></a> [tgt\_dms\_certificate\_name](#input\_tgt\_dms\_certificate\_name) | Certificate Name (For SSL) of the Target endpoint connection to be created | `string` | `"dms-target-ep-certificate"` | no |
| <a name="input_tgt_ep_prefix"></a> [tgt\_ep\_prefix](#input\_tgt\_ep\_prefix) | DMS endpoint prefix for the Target DB | `string` | `""` | no |
| <a name="input_tgt_extra_connection_attributes"></a> [tgt\_extra\_connection\_attributes](#input\_tgt\_extra\_connection\_attributes) | DMS Extra connection attributes for target endpoints | `string` | `null` | no |
| <a name="input_tgt_kms_alias"></a> [tgt\_kms\_alias](#input\_tgt\_kms\_alias) | KMS key alias that will be used to encrypt the endpoint | `string` | `"aws/dms"` | no |
| <a name="input_tgt_ssl_mode"></a> [tgt\_ssl\_mode](#input\_tgt\_ssl\_mode) | Is the DB connection SSL Enabled ? [none require verify-ca verify-full] | `string` | `"none"` | no |
| <a name="input_use_cdc"></a> [use\_cdc](#input\_use\_cdc) | Is the migration required change data capture ? | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_replication_instance_arns"></a> [replication\_instance\_arns](#output\_replication\_instance\_arns) | List of Replication Instance's ARN |
| <a name="output_replication_instance_names"></a> [replication\_instance\_names](#output\_replication\_instance\_names) | List of Replication Instance's name |
| <a name="output_source_non_oracle_endpoint_arn"></a> [source\_non\_oracle\_endpoint\_arn](#output\_source\_non\_oracle\_endpoint\_arn) | ARN of the Source Endpoint for Non Oracle Target |
| <a name="output_source_non_oracle_endpoint_name"></a> [source\_non\_oracle\_endpoint\_name](#output\_source\_non\_oracle\_endpoint\_name) | Name of the Source Endpoint for Non Oracle Target |
| <a name="output_source_oracle_binaryreader_endpoint_arn"></a> [source\_oracle\_binaryreader\_endpoint\_arn](#output\_source\_oracle\_binaryreader\_endpoint\_arn) | ARN of the Source Endpoint for Oracle Binary Reader |
| <a name="output_source_oracle_binaryreader_endpoint_name"></a> [source\_oracle\_binaryreader\_endpoint\_name](#output\_source\_oracle\_binaryreader\_endpoint\_name) | Name of the Source Endpoint for Oracle Binary Reader |
| <a name="output_source_oracle_logminer_endpoint_arn"></a> [source\_oracle\_logminer\_endpoint\_arn](#output\_source\_oracle\_logminer\_endpoint\_arn) | ARN of the Source Endpoint for Oracle Logminer |
| <a name="output_source_oracle_logminer_endpoint_name"></a> [source\_oracle\_logminer\_endpoint\_name](#output\_source\_oracle\_logminer\_endpoint\_name) | Name of the Source Endpoint for Oracle Logminer |
| <a name="output_target_endpoint_arn"></a> [target\_endpoint\_arn](#output\_target\_endpoint\_arn) | Target Endpoint ARN |
| <a name="output_target_endpoint_name"></a> [target\_endpoint\_name](#output\_target\_endpoint\_name) | Target Endpoint Name |
<!-- END_TF_DOCS -->
