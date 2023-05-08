resource "aws_ssm_parameter" "dms_subnet_id" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/dms/subnet_id"
  type  = "StringList"
  value = var.dms_subnet_id
}

resource "aws_ssm_parameter" "dms_subnet_group_id" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/dms/subnet_group_id"
  type  = "String"
  value = var.dms_subnet_group_id
}

resource "aws_ssm_parameter" "dms_ri_count" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/dms/ri_count"
  type  = "String"
  value = var.dms_ri_count
}

resource "aws_ssm_parameter" "dms_ri_prefix" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/dms/ri_prefix"
  type  = "String"
  value = var.dms_ri_prefix

}

resource "aws_ssm_parameter" "dms_ri_multi_az" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/dms/ri_multi_az"
  type  = "String"
  value = var.dms_ri_multi_az
}

resource "aws_ssm_parameter" "dms_ri_public_access" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/dms/ri_public_access"
  type  = "String"
  value = var.dms_ri_public_access

}

resource "aws_ssm_parameter" "dms_ri_az" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/dms/ri_az"
  type  = "String"
  value = var.dms_ri_az

}

resource "aws_ssm_parameter" "dms_ri_instnace_class" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/dms/ri_instnace_class"
  type  = "String"
  value = var.dms_ri_instnace_class
}

resource "aws_ssm_parameter" "dms_ri_engine_version" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/dms/ri_engine_version"
  type  = "String"
  value = var.dms_ri_engine_version
}

resource "aws_ssm_parameter" "dms_ri_allocated_storage" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/dms/ri_allocated_storage"
  type  = "String"
  value = var.dms_ri_allocated_storage

}

resource "aws_ssm_parameter" "dms_ri_sg_ids" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/dms/ri_sg_ids"
  type  = "StringList"
  value = var.dms_ri_sg_ids

}

resource "aws_ssm_parameter" "dms_ri_sns_topic" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/dms/ri_sns_topic"
  type  = "String"
  value = var.dms_ri_sns_topic
}

resource "aws_ssm_parameter" "dms_ri_cw_logs_retention" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/dms/ri_cw_logs_retention"
  type  = "String"
  value = var.dms_ri_cw_logs_retention
}

resource "aws_ssm_parameter" "dms_ri_maint_window" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/dms/ri_maint_window"
  type  = "String"
  value = var.dms_ri_maint_window
}

resource "aws_ssm_parameter" "dms_cw_custom_namespace" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/dms/cw_custom_namespace"
  type  = "String"
  value = var.dms_cw_custom_namespace
}

resource "aws_ssm_parameter" "dms_create_subnet_group" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/dms/create_subnet_group"
  type  = "String"
  value = var.dms_create_subnet_group
}

resource "aws_ssm_parameter" "dms_create_default_roles" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/dms/create_default_roles"
  type  = "String"
  value = var.dms_create_default_roles
}