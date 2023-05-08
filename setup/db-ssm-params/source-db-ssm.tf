resource "aws_ssm_parameter" "source_read_replica" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/source/read_replica"
  type  = "String"
  value = var.source_read_replica
}

resource "aws_ssm_parameter" "source_rds" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/source/rds"
  type  = "String"
  value = var.source_rds
}

resource "aws_ssm_parameter" "source_use_cdc" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/source/use_cdc"
  type  = "String"
  value = var.source_use_cdc

}

resource "aws_ssm_parameter" "source_extra_connection_attributes" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/source/extra_connection_attributes"
  type  = "String"
  value = var.source_extra_connection_attributes

}

resource "aws_ssm_parameter" "source_db_engine" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/source/db/engine"
  type  = "String"
  value = var.source_db_engine
}

resource "aws_ssm_parameter" "source_db_port" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/source/db/port"
  type  = "String"
  value = var.source_db_port
}

resource "aws_ssm_parameter" "source_db_name" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/source/db/name"
  type  = "String"
  value = var.source_db_name
}

resource "aws_ssm_parameter" "source_db_host" {
  name   = "${var.ssm_prefix}/source/db/host"
  type   = "SecureString"
  key_id = aws_kms_alias.this.target_key_arn
  value  = var.source_db_host
}

resource "aws_ssm_parameter" "source_db_version" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/source/db/version"
  type  = "String"
  value = var.source_db_version
}

resource "aws_ssm_parameter" "source_db_secret_mgr_name" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/source/db/secret_mgr_name"
  type  = "String"
  value = var.source_db_secret_mgr_name
}

resource "aws_ssm_parameter" "source_db_dms_endpoint_prefix" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/source/db/dms_endpoint_prefix"
  type  = "String"
  value = var.source_db_dms_endpoint_prefix
}

resource "aws_ssm_parameter" "source_create_src_dms_certificate" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/source/create_src_dms_certificate"
  type  = "String"
  value = var.source_create_src_dms_certificate
}

resource "aws_ssm_parameter" "source_dms_certificate_name" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/source/dms_certificate_name"
  type  = "String"
  value = var.source_dms_certificate_name
}

resource "aws_ssm_parameter" "source_dms_certificate_arn" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/source/dms_certificate_arn"
  type  = "String"
  value = var.source_dms_certificate_arn
}