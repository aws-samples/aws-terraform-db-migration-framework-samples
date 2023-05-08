data "aws_iam_policy_document" "dms_assume_role" {
  count = var.create_default_dms_roles ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["dms.amazonaws.com"]
      type        = "Service"
    }
  }
}