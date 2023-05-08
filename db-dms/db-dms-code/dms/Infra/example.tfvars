create_default_dms_roles = true
create_dms_subnet_group = true
dms_subnet_group_id     = "dms-subnet-group-by-tf"
dms_subnet_ids          = ["xxxxxxxxx", "xxxxxxxxx", "xxxxxxxxx"]
ri_count                        = 2
ri_prefix                       = "demo-ri"
ri_multi_az                     = false
ri_publicly_accessible          = false
ri_availability_zone            = null
ri_instance_class               = "dms.t3.large"
ri_engine_version               = "3.4.6"
ri_allocated_storage            = 100
ri_vpc_security_group_ids       = ["xxxxxxxxx"]
ri_monitoring_sns_topic         = "DEMO_SNS_NOTIFY"
ri_cw_logs_retentions           = 3
CW_CustomNameSpace              = "CustomMetrics/DMS"
ri_preferred_maintenance_window = "sun:10:30-sun:14:30"
# ri_kms_alias              = 'Allow to use default value aws/dms'

oracle_db_version = "12.1"

src_db_secret = "MasterUser"
# src_kms_alias       = ""
src_ep_prefix = "projectname"
src_db_engine = "oracle"
src_db_user   = "master"
src_db_pwd    = "xxxxxxxxx"
src_db_name   = "demodb"
src_db_port   = 1521
src_db_host   = "demodb.xxxxxx.us-east-1.rds.amazonaws.com"
#src_ssl_mode        = # allowed values : [none require verify-ca verify-full]
src_read_replica = false
src_rds          = true
use_cdc          = true

src_extra_connection_attributes = ""
create_src_dms_certificate      = false
src_dms_certificate_name        = "demo-oracle-dms-certificate"
src_dms_certificate_arn         = null

#--------------------------------------------
# Target DB Endpoint creation
#--------------------------------------------

tgt_db_secret                   = "demo-apg-cluster-db-master-user-secret"
# tgt_kms_alias                 = ""
tgt_ep_prefix                   = "demo"
tgt_db_engine                   = "postgres"
tgt_db_user                     = "master"
tgt_db_pwd                      = "xxxxxxxxx"
tgt_db_name                     = "pgdb01"
tgt_db_port                     = 5432
tgt_db_host                     = "demo-apg-cluster-db.cluster-xxxxxx.us-east-1.rds.amazonaws.com"
tgt_ssl_mode                    = "require"
tgt_extra_connection_attributes = ""
create_tgt_dms_certificate      = true
tgt_dms_certificate_name        = "demo-apg-dms-certificate"
tgt_dms_certificate_arn         = null