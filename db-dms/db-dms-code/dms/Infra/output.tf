output "replication_instance_names" {
  description = "List of Replication Instance's name"
  value       = aws_dms_replication_instance.rep_inst.*.replication_instance_id
}

output "replication_instance_arns" {
  description = "List of Replication Instance's ARN"
  value       = aws_dms_replication_instance.rep_inst.*.replication_instance_arn
}

output "source_endpoint_name" {
  description = "Source Endpoint Name"
  value       = "${var.src_ep_prefix}-src-${var.src_db_engine}-ep"
}

output "source_endpoint_arn" {
  description = "Source Endpoint ARN"
  value       = element(concat(aws_dms_endpoint.src_db_ep.*.endpoint_arn, [""]), 0)
}

output "target_endpoint_name" {
  description = "Target Endpoint Name"
  value       = "${var.tgt_ep_prefix}-tgt-${var.tgt_db_engine}-ep"
}

output "target_endpoint_arn" {
  description = "Target Endpoint ARN"
  value       = element(concat(aws_dms_endpoint.tgt_db_ep.*.endpoint_arn, [""]), 0)
}
