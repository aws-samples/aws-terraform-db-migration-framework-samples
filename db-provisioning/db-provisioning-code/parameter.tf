resource "aws_db_parameter_group" "default" {
  name   = "rds-pg"
  family = var.family

  parameter {
    name  = "rds.force_ssl"
    value = "1"
  }
}
