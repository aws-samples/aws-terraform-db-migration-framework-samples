resource "aws_ssm_parameter" "db" {
  name  = "/demo/dbdevops/target/db/ssm/host"
  type  = "SecureString"
  value = aws_db_instance.default.address
}