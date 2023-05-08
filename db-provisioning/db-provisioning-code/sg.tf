resource "aws_security_group" "test-rds" {
  #checkov:skip=CKV_AWS_23: "Ensure every security groups rule has a description"
  name        = "dynamic-sg"
  description = "Security Groups for ec2"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.sg_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = var.protocol
      cidr_blocks = var.cidr_blocks
    }
  }
}
