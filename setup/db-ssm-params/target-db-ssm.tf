resource "aws_ssm_parameter" "target_identifier" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/identifier"
  type  = "String"
  value = var.target_identifier
}

resource "aws_ssm_parameter" "target_sg_ports" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/db/sg_ports"
  type  = "String"
  value = var.target_db_sg_ports
}

resource "aws_ssm_parameter" "target_from_db_port" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/from_db_port"
  type  = "String"
  value = var.target_from_db_port
}

resource "aws_ssm_parameter" "target_to_db_port" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/to_db_port"
  type  = "String"
  value = var.target_to_db_port
}

resource "aws_ssm_parameter" "target_project_name" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/project_name"
  type  = "String"
  value = var.target_project_name
}

resource "aws_ssm_parameter" "target_repo_name" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/repo_name"
  type  = "String"
  value = var.target_repo_name
}

resource "aws_ssm_parameter" "target_repo_branch" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/repo_branch"
  type  = "String"
  value = var.target_repo_branch
}

resource "aws_ssm_parameter" "target_db_name" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/db/name"
  type  = "String"
  value = var.target_db_name
}

resource "aws_ssm_parameter" "target_db_parameter_group_name" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/db/parameter_group_name"
  type  = "String"
  value = var.target_db_parameter_group_name
}

resource "aws_ssm_parameter" "target_infra_subnet_ids" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/infra/subnet_ids"
  type  = "StringList"
  value = var.target_infra_subnet_ids
}

resource "aws_ssm_parameter" "target_infra_aws_region" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/infra/aws_region"
  type  = "String"
  value = var.target_infra_aws_region
}

resource "aws_ssm_parameter" "target_infra_aws_account_id" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/infra/aws_account_id"
  type  = "String"
  value = var.target_infra_aws_account_id
}

resource "aws_ssm_parameter" "target_db_port" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/db/port"
  type  = "String"
  value = var.target_db_port
}

resource "aws_ssm_parameter" "target_db_dbname" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/db/dbname"
  type  = "String"
  value = var.target_db_dbname
}

resource "aws_ssm_parameter" "target_db_allocated_storage" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/db/allocated_storage"
  type  = "String"
  value = var.target_db_allocated_storage
}

resource "aws_ssm_parameter" "target_db_max_allocated_storage" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/db/max_allocated_storage"
  type  = "String"
  value = var.target_db_max_allocated_storage
}

resource "aws_ssm_parameter" "target_db_engine" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/db/engine"
  type  = "String"
  value = var.target_db_engine
}

resource "aws_ssm_parameter" "target_db_engine_version" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/db/engine_version"
  type  = "String"
  value = var.target_db_engine_version
}

resource "aws_ssm_parameter" "target_db_instace_class" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/db/instace_class"
  type  = "String"
  value = var.target_db_instace_class
}

resource "aws_ssm_parameter" "target_db_transit" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/db/transit"
  type  = "String"
  value = var.target_db_transit
}

resource "aws_ssm_parameter" "target_db_family" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/db/family"
  type  = "String"
  value = var.target_db_family
}

resource "aws_ssm_parameter" "target_db_backup_retention_period" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/db/backup_retention_period"
  type  = "String"
  value = var.target_db_backup_retention_period
}

resource "aws_ssm_parameter" "target_infra_vpc_id" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/infra/vpc_id"
  type  = "String"
  value = var.target_infra_vpc_id
}

resource "aws_ssm_parameter" "target_infra_cidr_blocks" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/infra/cidr_blocks"
  type  = "String"
  value = var.target_infra_cidr_blocks
}

resource "aws_ssm_parameter" "target_infra_sg_id" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/infra/sg_id"
  type  = "String"
  value = var.target_infra_sg_id
}

resource "aws_ssm_parameter" "target_db_secret_mgr_name" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/db/secret_mgr_name"
  type  = "String"
  value = var.target_db_secret_mgr_name
}

resource "aws_ssm_parameter" "target_db_ssl_mode" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/db/ssl_mode"
  type  = "String"
  value = var.target_db_ssl_mode
}

resource "aws_ssm_parameter" "target_db_extra_connection_attributes" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/db/extra_connection_attributes"
  type  = "String"
  value = var.target_db_extra_connection_attributes
}

resource "aws_ssm_parameter" "target_db_dms_endpoint_prefix" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/db/dms_endpoint_prefix"
  type  = "String"
  value = var.target_db_dms_endpoint_prefix
}

resource "aws_ssm_parameter" "target_db_create_tgt_dms_certificate" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/db/create_tgt_dms_certificate"
  type  = "String"
  value = var.target_db_create_tgt_dms_certificate
}

resource "aws_ssm_parameter" "target_db_dms_certificate_name" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/db/dms_certificate_name"
  type  = "String"
  value = var.target_db_dms_certificate_name
}

resource "aws_ssm_parameter" "target_db_tgt_dms_certificate_arn" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/db/dms_certificate_arn"
  type  = "String"
  value = var.target_db_dms_certificate_arn
}

resource "aws_ssm_parameter" "target_client" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/client"
  type  = "String"
  value = var.target_client
}