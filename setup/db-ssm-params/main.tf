#KMS Keys
resource "aws_kms_key" "this" {
  description             = "This is KMS Key Id used to encrypt/decrypt the Secret"
  deletion_window_in_days = var.kms_deletion_window_in_days
  enable_key_rotation     = true
}

resource "aws_kms_alias" "this" {
  name          = "alias/${var.key_alias}"
  target_key_id = aws_kms_key.this.key_id
}

resource "aws_ssm_parameter" "environment" {
  #checkov:skip=CKV2_AWS_34:The SSM parameter is configuration parameter
  name  = "${var.ssm_prefix}/target/environment"
  type  = "String"
  value = var.target_environment
}