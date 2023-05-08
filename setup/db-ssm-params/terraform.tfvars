#main ssm
kms_deletion_window_in_days = "30"
ssm_prefix                  = "/demo/dbdevops"
key_alias                   = "aws-encryption-key"

#dms-ssm
dms_subnet_id            = "[\"subnet-xxxxxxx\", \"subnet-xxxxxxx\"]"
dms_subnet_group_id      = "demo-group"
dms_ri_count             = "2"
dms_ri_prefix            = "demo-project-ri"
dms_ri_multi_az          = false
dms_ri_public_access     = false
dms_ri_az                = "null"
dms_ri_instnace_class    = "dms.t3.large"
dms_ri_engine_version    = "3.4.6"
dms_ri_allocated_storage = "100"
dms_ri_sg_ids            = "[\"sg-xxxxxxx\"]"
dms_ri_sns_topic         = "DEMO_SNS_NOTIFY"
dms_ri_cw_logs_retention = "3"
dms_ri_maint_window      = "sun:22:30-sun:23:30"
dms_cw_custom_namespace  = "CustomMetrics/DMS"
dms_create_subnet_group  = true
dms_create_default_roles = true

#source ssm
source_read_replica                = false
source_rds                         = true
source_use_cdc                     = false
source_extra_connection_attributes = "null"
source_db_engine                   = "oracle"
source_db_host                    = "demo.xxxxxx.us-east-2.rds.amazonaws.com"
source_db_port                    = "1521"
source_db_name                    = "demo"
source_db_version                 = "12.1"
source_db_secret_mgr_name         = "demo-secret-manager-name"
source_db_dms_endpoint_prefix     = "Demodb"
source_create_src_dms_certificate = false
source_dms_certificate_name       = "demo-oracle-dms-certificate"
source_dms_certificate_arn        = "null"

#target ssm
target_environment                    = "dev"
target_identifier                     = "demodb"
target_db_sg_ports                    = "[5432, 443]"
target_from_db_port                   = "5432"
target_to_db_port                     = "5432"
target_project_name                   = "dbrds"
target_repo_name                      = "terraform-aws-db-infra-cicd"
target_repo_branch                    = "main"
target_db_name                        = "demo-test"
target_db_parameter_group_name        = "default.postgres14"
target_infra_subnet_ids               = "[\"subnet-xxxxxxx\", \"subnet-xxxxxxx\"]"
target_infra_aws_region               = "us-east-2"
target_infra_aws_account_id           = "xxxxxxx"
target_db_port                        = "5432"
target_db_dbname                      = "demodb"
target_db_allocated_storage           = "30"
target_db_max_allocated_storage       = "50"
target_db_engine                      = "postgres"
target_db_engine_version              = "14.3"
target_db_instace_class               = "db.m5.large"
target_db_transit                     = false
target_db_family                      = "postgres14"
target_db_backup_retention_period     = "3"
target_infra_vpc_id                   = "vpc-xxxxxxx"
target_infra_cidr_blocks              = "[\"10.0.0.0/16\"]"
target_infra_sg_id                    = "sg-xxxxxxx"
target_db_secret_mgr_name             = "demo-secre-manager-name"
target_db_ssl_mode                    = "require"
target_db_extra_connection_attributes = "null"
target_db_dms_endpoint_prefix         = "demo"
target_db_create_tgt_dms_certificate  = true
target_db_dms_certificate_name        = "demo-dms-certificate"
target_db_dms_certificate_arn         = "null"
target_client                         = "db"

#--------------#






















