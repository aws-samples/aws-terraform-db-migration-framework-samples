resource "aws_dms_replication_subnet_group" "dms_subnet_group" {
  count = var.create_dms_subnet_group ? 1 : 0

  replication_subnet_group_description = "DMS Replication subnet group"
  replication_subnet_group_id          = var.dms_subnet_group_id
  subnet_ids                           = var.dms_subnet_ids
}

data "aws_kms_key" "ri_kms_arn" {
  key_id = "alias/${var.ri_kms_arn}"
}

resource "aws_dms_replication_instance" "rep_inst" {
  count = var.ri_count

  replication_instance_id      = "${replace(var.ri_prefix, "_", "-")}-${(count.index) + 1}"
  apply_immediately            = true
  allow_major_version_upgrade  = false
  auto_minor_version_upgrade   = false
  multi_az                     = var.ri_multi_az
  preferred_maintenance_window = var.ri_preferred_maintenance_window
  publicly_accessible          = var.ri_publicly_accessible
  availability_zone            = var.ri_availability_zone
  replication_instance_class   = var.ri_instance_class
  engine_version               = var.ri_engine_version
  replication_subnet_group_id  = var.create_dms_subnet_group ? aws_dms_replication_subnet_group.dms_subnet_group[0].id : var.dms_subnet_group_id
  allocated_storage            = var.ri_allocated_storage
  vpc_security_group_ids       = var.ri_vpc_security_group_ids
  kms_key_arn                  = data.aws_kms_key.ri_kms_arn.arn
  tags = merge({ Name = "${var.ri_prefix}-${(count.index) + 1}" }, var.common_tags)
  lifecycle { ignore_changes = [availability_zone, replication_instance_id] }

  # checkov:skip=CKV_AWS_222: auto_minor_version_upgrade set to false intentionally
}

data "aws_kms_key" "src_kms_alias" {
  key_id = "alias/${var.src_kms_alias}"
}

resource "aws_dms_certificate" "src_certificate" {
  count           = var.create_src_dms_certificate ? 1 : 0
  certificate_id  = var.src_dms_certificate_name
  certificate_pem = file("${path.module}/../Certificates/oracle_db.pem")
  tags            = merge({ Name = var.src_dms_certificate_name }, var.common_tags)
}

data "aws_secretsmanager_secret_version" "src_secret" {
  count     = length(var.src_db_secret) > 0 ? 1 : 0
  secret_id = var.src_db_secret
}

data "aws_secretsmanager_secret_version" "tgt_secret" {
  count     = length(var.tgt_db_secret) > 0 ? 1 : 0
  secret_id = var.tgt_db_secret
}

locals {
  src_db_engine = length(var.src_db_secret) > 0 ? lookup(jsondecode(data.aws_secretsmanager_secret_version.src_secret[0].secret_string), "engine", var.src_db_engine) : var.src_db_engine
  src_db_user   = length(var.src_db_secret) > 0 ? lookup(jsondecode(data.aws_secretsmanager_secret_version.src_secret[0].secret_string), "username", var.src_db_user) : var.src_db_user
  src_db_pwd    = length(var.src_db_secret) > 0 ? lookup(jsondecode(data.aws_secretsmanager_secret_version.src_secret[0].secret_string), "password", var.src_db_pwd) : var.src_db_pwd
  src_db_name   = length(var.src_db_secret) > 0 ? lookup(jsondecode(data.aws_secretsmanager_secret_version.src_secret[0].secret_string), "db_name", var.src_db_name) : var.src_db_name
  src_db_port   = length(var.src_db_secret) > 0 ? lookup(jsondecode(data.aws_secretsmanager_secret_version.src_secret[0].secret_string), "db_port", var.src_db_port) : var.src_db_port
  src_db_host   = length(var.src_db_secret) > 0 ? lookup(jsondecode(data.aws_secretsmanager_secret_version.src_secret[0].secret_string), "db_host", var.src_db_host) : var.src_db_host
}

resource "aws_dms_endpoint" "src_db_ep" {
  endpoint_id                 = "${var.src_ep_prefix}-src-ep"
  endpoint_type               = "source"
  engine_name                 = local.src_db_engine
  username                    = local.src_db_user
  password                    = local.src_db_pwd
  database_name               = local.src_db_name
  port                        = local.src_db_port
  server_name                 = local.src_db_host
  kms_key_arn                 = data.aws_kms_key.src_kms_alias.arn
  ssl_mode                    = var.src_ssl_mode
  certificate_arn             = var.create_src_dms_certificate ? aws_dms_certificate.src_certificate[0].certificate_arn : var.src_dms_certificate_arn
  extra_connection_attributes = var.src_extra_connection_attributes
  tags = merge({ Name = "${var.src_ep_prefix}-src-${var.src_db_engine}" }, var.common_tags)
}

#--------------------------------------------
# Target DB Endpoint creation
#--------------------------------------------

data "aws_kms_key" "tgt_kms_alias" {
  key_id = "alias/${var.tgt_kms_alias}"
}

resource "aws_dms_certificate" "tgt_certificate" {
  count           = var.create_tgt_dms_certificate ? 1 : 0
  certificate_id  = var.tgt_dms_certificate_name
  certificate_pem = file("${path.module}/../Certificates/Aurora-global-bundle.pem")
  tags            = merge({ Name = var.tgt_dms_certificate_name }, var.common_tags)
}

locals {
  tgt_db_engine = length(var.tgt_db_secret) > 0 ? lookup(jsondecode(data.aws_secretsmanager_secret_version.tgt_secret[0].secret_string), "engine", var.tgt_db_engine) : var.tgt_db_engine
  tgt_db_user   = length(var.tgt_db_secret) > 0 ? lookup(jsondecode(data.aws_secretsmanager_secret_version.tgt_secret[0].secret_string), "username", var.tgt_db_user) : var.tgt_db_user
  tgt_db_pwd    = length(var.tgt_db_secret) > 0 ? lookup(jsondecode(data.aws_secretsmanager_secret_version.tgt_secret[0].secret_string), "password", var.tgt_db_pwd) : var.tgt_db_pwd
  tgt_db_name   = length(var.tgt_db_secret) > 0 ? lookup(jsondecode(data.aws_secretsmanager_secret_version.tgt_secret[0].secret_string), "db_name", var.tgt_db_name) : var.tgt_db_name
  tgt_db_port   = length(var.tgt_db_secret) > 0 ? lookup(jsondecode(data.aws_secretsmanager_secret_version.tgt_secret[0].secret_string), "db_port", var.tgt_db_port) : var.tgt_db_port
  tgt_db_host   = length(var.tgt_db_secret) > 0 ? lookup(jsondecode(data.aws_secretsmanager_secret_version.tgt_secret[0].secret_string), "db_host", var.tgt_db_host) : var.tgt_db_host
}

resource "aws_dms_endpoint" "tgt_db_ep" {
  # checkov:skip=CKV2_AWS_49: DMS endpoints does not has configured SSL
  endpoint_id                 = "${var.tgt_ep_prefix}-tgt-ep"
  endpoint_type               = "target"
  certificate_arn             = var.create_tgt_dms_certificate ? aws_dms_certificate.tgt_certificate[0].certificate_arn : var.tgt_dms_certificate_arn
  engine_name                 = local.tgt_db_engine
  username                    = local.tgt_db_user
  password                    = local.tgt_db_pwd
  database_name               = local.tgt_db_name
  port                        = local.tgt_db_port
  server_name                 = local.tgt_db_host
  ssl_mode                    = var.tgt_ssl_mode
  kms_key_arn                 = data.aws_kms_key.tgt_kms_alias.arn
  extra_connection_attributes = var.tgt_extra_connection_attributes
}
