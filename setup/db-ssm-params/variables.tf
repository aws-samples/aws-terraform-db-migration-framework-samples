#main ssm
variable "ssm_prefix" {
  type        = string
  description = "Provide Prefix for ssm parameters"
}

variable "kms_deletion_window_in_days" {
  type        = number
  description = "kms_deletion_window_in_days"
  default     = 30
}

variable "key_alias" {
  type        = string
  description = "KMS key alias"
  default     = "aws-encryption-key"
}

#dms-ssm
variable "dms_subnet_id" {
  type        = string
  description = "value"
}

variable "dms_subnet_group_id" {
  type        = string
  description = "value"
}

variable "dms_ri_count" {
  type        = string
  description = "value"
}

variable "dms_ri_prefix" {
  type        = string
  description = "value"
}

variable "dms_ri_multi_az" {
  type        = string
  description = "value"
}

variable "dms_ri_public_access" {
  type        = string
  description = "value"
}

variable "dms_ri_az" {
  type        = string
  description = "value"
}
variable "dms_ri_instnace_class" {
  type        = string
  description = "value"
}

variable "dms_ri_engine_version" {
  type        = string
  description = "value"
}

variable "dms_ri_allocated_storage" {
  type        = string
  description = "value"
}

variable "dms_ri_sg_ids" {
  type        = string
  description = "value"
}

variable "dms_ri_sns_topic" {
  type        = string
  description = "value"
}

variable "dms_ri_cw_logs_retention" {
  type        = string
  description = "value"
}
variable "dms_ri_maint_window" {
  type        = string
  description = "value"
}

variable "dms_cw_custom_namespace" {
  type        = string
  description = "value"
}

variable "dms_create_subnet_group" {
  type        = string
  description = "value"
}

variable "dms_create_default_roles" {
  type        = string
  description = "value"
}


#source ssm

variable "source_read_replica" {
  type        = string
  description = "value"
}

variable "source_rds" {
  type        = string
  description = "value"
}
variable "source_use_cdc" {
  type        = string
  description = "value"
}

variable "source_extra_connection_attributes" {
  type        = string
  description = "value"
}

variable "source_db_engine" {
  type        = string
  description = "value"
}

# variable "source_db_username" {
#   type        = string
#   description = "value"
# }

variable "source_db_port" {
  type        = string
  description = "value"
}

# variable "source_db_password" {
#   type        = string
#   description = "value"
# }
variable "source_db_name" {
  type        = string
  description = "value"
}

variable "source_db_host" {
  type        = string
  description = "value"
}

variable "source_db_version" {
  type        = string
  description = "value"
}

variable "source_db_secret_mgr_name" {
  type        = string
  description = "value"
}

variable "source_db_dms_endpoint_prefix" {
  type        = string
  description = "value"
}

variable "source_create_src_dms_certificate" {
  type        = string
  description = "value"
}
variable "source_dms_certificate_name" {
  type        = string
  description = "value"
}

variable "source_dms_certificate_arn" {
  type        = string
  description = "value"
}

#target ssm


variable "target_environment" {
  type        = string
  description = "value"
}

variable "target_identifier" {
  type        = string
  description = "value"
}

variable "target_db_sg_ports" {
  type        = string
  description = "value"
}

variable "target_from_db_port" {
  type        = string
  description = "value"
}
variable "target_to_db_port" {
  type        = string
  description = "value"
}

variable "target_project_name" {
  type        = string
  description = "value"
}

variable "target_repo_name" {
  type        = string
  description = "value"
}

variable "target_repo_branch" {
  type        = string
  description = "value"
}

variable "target_db_name" {
  type        = string
  description = "value"
}

variable "target_db_parameter_group_name" {
  type        = string
  description = "value"
}
variable "target_infra_subnet_ids" {
  type        = string
  description = "value"
}

variable "target_infra_aws_region" {
  type        = string
  description = "value"
}

variable "target_infra_aws_account_id" {
  type        = string
  description = "value"
}

variable "target_db_port" {
  type        = string
  description = "value"
}

# variable "target_db_username" {
#   type        = string
#   description = "value"
# }

# variable "target_db_password" {
#   type        = string
#   description = "value"
# }
variable "target_db_dbname" {
  type        = string
  description = "value"
}

variable "target_db_allocated_storage" {
  type        = string
  description = "value"
}

variable "target_db_max_allocated_storage" {
  type        = string
  description = "value"
}

variable "target_db_engine" {
  type        = string
  description = "value"
}

variable "target_db_engine_version" {
  type        = string
  description = "value"
}

variable "target_db_instace_class" {
  type        = string
  description = "value"
}
variable "target_db_transit" {
  type        = string
  description = "value"
}

variable "target_db_family" {
  type        = string
  description = "value"
}

variable "target_db_backup_retention_period" {
  type        = string
  description = "value"
}

variable "target_infra_vpc_id" {
  type        = string
  description = "value"
}

variable "target_infra_cidr_blocks" {
  type        = string
  description = "value"
}

variable "target_infra_sg_id" {
  type        = string
  description = "value"
}
variable "target_db_secret_mgr_name" {
  type        = string
  description = "value"
}

variable "target_db_ssl_mode" {
  type        = string
  description = "value"
}

variable "target_db_extra_connection_attributes" {
  type        = string
  description = "value"
}

variable "target_db_dms_endpoint_prefix" {
  type        = string
  description = "value"
}

variable "target_db_create_tgt_dms_certificate" {
  type        = string
  description = "value"
}

variable "target_db_dms_certificate_name" {
  type        = string
  description = "value"
}
variable "target_db_dms_certificate_arn" {
  type        = string
  description = "value"
}

variable "target_client" {
  type        = string
  description = "value"
}
