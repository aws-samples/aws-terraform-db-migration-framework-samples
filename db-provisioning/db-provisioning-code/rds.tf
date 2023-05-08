data "aws_secretsmanager_secret_version" "tgt_secret" {
  count     = length(var.tgt_db_secret) > 0 ? 1 : 0
  secret_id = var.tgt_db_secret
}

locals {
  tgt_db_user   = length(var.tgt_db_secret) > 0 ? lookup(jsondecode(data.aws_secretsmanager_secret_version.tgt_secret[0].secret_string), "username", var.username) : var.username
  tgt_db_pwd    = length(var.tgt_db_secret) > 0 ? lookup(jsondecode(data.aws_secretsmanager_secret_version.tgt_secret[0].secret_string), "password", var.password) : var.password
}

#tfsec:ignore:aws-rds-enable-performance-insights
resource "aws_db_instance" "default" {
  #checkov:skip=CKV_AWS_157: "Ensure that RDS instances have Multi-AZ enabled"
  #checkov:skip=CKV_AWS_118: "Ensure that enhanced monitoring is enabled for Amazon RDS instances"
  #checkov:skip=CKV_AWS_226: "Ensure DB instance gets all minor upgrades automatically"
  allocated_storage               = var.allocated_storage
  max_allocated_storage           = var.max_allocated_storage
  engine                          = var.engine
  engine_version                  = var.engine_version
  instance_class                  = var.instance_class
  identifier                      = var.identifier
  backup_retention_period         = var.backup_retention_period
  db_subnet_group_name            = aws_db_subnet_group.subnet_group.name
  storage_encrypted               = true
  db_name                         = var.db_name
  username                        = local.tgt_db_user
  password                        = local.tgt_db_pwd
#  parameter_group_name            = var.transit == "true" ? aws_db_parameter_group.default.name : var.parameter_group_name
  skip_final_snapshot             = true
  port                            = var.port
  vpc_security_group_ids          = ["${aws_security_group.test-rds.id}"]
  multi_az                        = var.env == "prod" ? true : false
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  tags = merge(
    local.common_tags,
    {
      Name = "${var.client}"
    }
  )

}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "postgres"
  subnet_ids = var.subnet_ids
  tags = merge(
    local.common_tags,
    {
      Name = "${var.client}"
    }
  )

}


