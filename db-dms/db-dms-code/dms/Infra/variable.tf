variable "common_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = null
}

variable "create_default_dms_roles" {
  description = "whether to create default DMS roles"
  type        = bool
  default     = false
}

variable "region" {
  description = "Region for the VPC"
  type        = string
  default     = "eu-west-1"
}

variable "create_dms_subnet_group" {
  description = "whether to create new subnet group for DMS replication instance"
  type        = bool
  default     = true
}

variable "dms_subnet_group_id" {
  description = "DMS Subnet group id for replication instance "
  type        = string
  default     = "default-dms-subnet-group"
}

variable "dms_subnet_ids" {
  description = "VPC Subnet group ids, those will be part of DMS Subnet Group"
  type        = list(any)
  default     = []
}

variable "ri_prefix" {
  description = "Replication Instance name prefix"
  type        = string
}

variable "ri_instance_class" {
  description = "Type of the ec2 instance used for replication instance"
  type        = string
  default     = "dms.t3.large"
}

variable "ri_kms_arn" {
  description = "KMS key ARN that will be used to encrypt the connection"
  type        = string
  default     = "aws/dms"
}

variable "ri_preferred_maintenance_window" {
  description = "AZ for replication instance"
  type        = string
  default     = "sun:10:30-sun:14:30"
}

variable "ri_availability_zone" {
  description = "AZ for replication instance"
  type        = string
  default     = null
}

variable "ri_multi_az" {
  description = "whether to enable multi AZ for replication instance"
  type        = bool
  default     = false
}

variable "ri_publicly_accessible" {
  description = "whether to enable publicly accessible for replication instance"
  type        = bool
  default     = false
}

variable "ri_engine_version" {
  description = "Replication engine version"
  type        = string
  default     = "3.1.3"
}

variable "ri_allocated_storage" {
  description = "Replication instance storage size in GB"
  type        = number
  default     = 100
}

variable "ri_count" {
  description = "Number of replication instance to use"
  type        = number
  default     = 2
}

variable "ri_vpc_security_group_ids" {
  description = "Replication instance security group ids"
  type        = list(any)
}

variable "ri_cw_logs_retentions" {
  description = "Cloudwatch Log Group retention for the Replication Instance"
  type        = number
  default     = 7
}

variable "ri_monitoring_sns_topic" {
  description = "SNS Topic to be used for DMS Replication Instance monitoring"
  type        = string
  default     = ""
}

variable "CW_CustomNameSpace" {
  description = "Cloudwatch Custom NameSpace to Publish Metric"
  type        = string
  default     = "CustomMetrics/DMS"
}

############################
# Source DB endpoint details
############################

variable "src_db_secret" {
  description = "Secret name for the Source DB"
  type        = string
  default     = ""
}

variable "src_ep_prefix" {
  description = "DMS endpoint prefix for the Source DB"
  type        = string
  default     = ""
}

variable "src_db_host" {
  description = "Source DB Host endpoint id"
  type        = string
  default     = ""
}

variable "src_db_port" {
  description = "Source DB port"
  type        = number
  default     = 1521
}

variable "src_db_engine" {
  description = "Source DB engine type"
  type        = string
}

variable "src_db_user" {
  description = "DMS Source Endpoint User name. Recommended to use srcDBhost_secret"
  type        = string
  default     = ""
}

variable "src_db_pwd" {
  description = "DMS Source Endpoint User password. Recommended to use srcDBhost_secret"
  type        = string
  default     = ""
}

variable "src_db_name" {
  description = "Source DB names"
  type        = string
  default     = ""
}

variable "src_read_replica" {
  description = "Is the Source DB read replica (Oracle Active Dataguard / RDS Read replica) ?"
  type        = bool
  default     = false
}

variable "src_rds" {
  description = "Is the Source DB RDS ?"
  type        = bool
  default     = false
}

variable "src_ssl_mode" {
  description = "Is the DB connection SSL Enabled ? [none require verify-ca verify-full]"
  type        = string
  default     = "none"
}

variable "oracle_db_version" {
  description = "Source Oracle database version"
  type        = string
  default     = "19"
}

variable "src_extra_connection_attributes" {
  description = "DMS Extra connection attributes for source endpoints"
  type        = string
  default     = ""
}

variable "src_kms_alias" {
  description = "KMS key alias that will be used to encrypt the endpoint "
  type        = string
  default     = "aws/dms"
}

variable "create_src_dms_certificate" {
  description = "Whether to create Certificate (For SSL) of the Source endpoint connection"
  type        = bool
  default     = false
}

variable "src_dms_certificate_name" {
  description = "Certificate Name (For SSL) of the Source endpoint connection to be created "
  type        = string
  default     = "dms-source-ep-certificate"
}

variable "src_dms_certificate_arn" {
  description = "Certificate ARN (For SSL) of the Source endpoint connection"
  type        = string
  default     = null
}

#############################
# Target DB endpoint details
#############################

variable "tgt_db_secret" {
  description = "Secret name for the Source DB"
  type        = string
  default     = ""
}

variable "tgt_ep_prefix" {
  description = "DMS endpoint prefix for the Target DB"
  type        = string
  default     = ""
}

variable "tgt_db_host" {
  description = "Target DB Host name/IP"
  type        = string
  default     = ""
}

variable "tgt_db_port" {
  description = "Target DB port"
  type        = number
}

variable "tgt_db_engine" {
  description = "Target DB engine type"
  type        = string
}

variable "tgt_db_user" {
  description = "DMS Target Endpoint User names"
  type        = string
  default     = ""
}

variable "tgt_db_pwd" {
  description = "DMS Target Endpoint User password"
  type        = string
  default     = ""
}

variable "tgt_db_name" {
  description = "Target DB names"
  type        = string
  default     = ""
}

variable "tgt_ssl_mode" {
  description = "Is the DB connection SSL Enabled ? [none require verify-ca verify-full]"
  type        = string
  default     = "none"
}

variable "tgt_extra_connection_attributes" {
  description = "DMS Extra connection attributes for target endpoints"
  type        = string
  default     = ""
}

variable "tgt_kms_alias" {
  description = "KMS key alias that will be used to encrypt the endpoint "
  type        = string
  default     = "aws/dms"
}

variable "create_tgt_dms_certificate" {
  description = "Whether to create Certificate (For SSL) of the Target endpoint connection"
  type        = bool
  default     = false
}

variable "tgt_dms_certificate_name" {
  description = "Certificate Name (For SSL) of the Target endpoint connection to be created "
  type        = string
  default     = "dms-target-ep-certificate"
}

variable "tgt_dms_certificate_arn" {
  description = "Certificate ARN (For SSL) of the Target endpoint connection"
  type        = string
  default     = null
}

###############################
# Replication Instance Mapping
###############################

variable "ri-mapping" {
  type    = list(any)
  default = ["2", "1", "2"]
}