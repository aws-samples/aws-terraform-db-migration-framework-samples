#!/bin/bash

# This script is used to update the AWS SSM Paramater Store values.
# PLEASE DO NOT CHECK-IN THIS SCRIPT WITH SENSITIVE VALUES.
# Steps to execute this script
# 1. Update the `ssmparametervalues` variable with SSM paramters in below form
# {ParameterName} :: {ParameterValue}
# Execute the script from LOCAL terminal `./ssm-paremeters.sh`
# NOTE: Please configure necessary AWS IAM role on local to execute this script.
# For List values do not add spaces in between

if [ $# -eq 0 ]
  then
    echo "Input region argument not provided"
    echo "Using us-east-1 as default region"
    region="us-east-1"
else
    region=$1
fi

echo "=========================================="
echo "Executing Bash Script [Script In Progress]"
echo "=========================================="

ssmparametervalues=(
'/demo/dbdevops/dms/create_default_roles :: true'
'/demo/dbdevops/dms/create_subnet_group :: true'
'/demo/dbdevops/dms/cw_custom_namespace :: CustomMetrics/DMS'
'/demo/dbdevops/dms/ri_allocated_storage :: 100'
'/demo/dbdevops/dms/ri_az :: null'
'/demo/dbdevops/dms/ri_count :: 2'
'/demo/dbdevops/dms/ri_cw_logs_retention :: 3'
'/demo/dbdevops/dms/ri_engine_version :: 3.4.6'
'/demo/dbdevops/dms/ri_instnace_class :: 	db.c5.large'
'/demo/dbdevops/dms/ri_maint_window :: sun:22:30-sun:23:30'
'/demo/dbdevops/dms/ri_multi_az :: false'
'/demo/dbdevops/dms/ri_prefix :: demo-project-ri'
'/demo/dbdevops/dms/ri_public_access :: false'
'/demo/dbdevops/dms/ri_sg_ids :: ["sg-xxxxxxx"]'
'/demo/dbdevops/dms/ri_sns_topic :: DEMO_SNS_NOTIFY'
'/demo/dbdevops/dms/subnet_group_id :: dms-dbtest-group'
'/demo/dbdevops/dms/subnet_id :: ["subnet-xxxxxxx","subnet-xxxxxxx","subnet-xxxxxxx"]'
'/demo/dbdevops/source/create_src_dms_certificate :: false'
'/demo/dbdevops/source/db/dms_endpoint_prefix :: Hypodb'
'/demo/dbdevops/source/db/engine :: oracle'
'/demo/dbdevops/source/db/host :: demo.xxxxxx.us-east-1.rds.amazonaws.com'
'/demo/dbdevops/source/db/name :: demo'
'/demo/dbdevops/source/db/password :: *****'
'/demo/dbdevops/source/db/port :: 1521'
'/demo/dbdevops/source/db/secret_mgr_name :: DemoSecretManager'
'/demo/dbdevops/source/db/username :: *****'
'/demo/dbdevops/source/db/version :: 19.0.0.0.ru-20xx-10.rur-20xx-10.r1'
'/demo/dbdevops/source/dms_certificate_arn :: null'
'/demo/dbdevops/source/dms_certificate_name :: demo-oracle-dms-certificate'
'/demo/dbdevops/source/extra_connection_attributes :: ""'
'/demo/dbdevops/source/rds :: true'
'/demo/dbdevops/source/read_replica :: false'
'/demo/dbdevops/source/use_cdc :: false'
'/demo/dbdevops/target/client :: db'
'/demo/dbdevops/target/db/allocated_storage :: 30'
'/demo/dbdevops/target/db/backup_retention_period :: 3'
'/demo/dbdevops/target/db/create_tgt_dms_certificate :: true'
'/demo/dbdevops/target/db/dbname :: demodb'
'/demo/dbdevops/target/db/dms_certificate_arn :: null'
'/demo/dbdevops/target/db/dms_certificate_name :: demo-dms-certificate'
'/demo/dbdevops/target/db/dms_endpoint_prefix :: demo'
'/demo/dbdevops/target/db/engine :: postgres'
'/demo/dbdevops/target/db/engine_version :: 14.2'
'/demo/dbdevops/target/db/extra_connection_attributes :: ""'
'/demo/dbdevops/target/db/family :: postgres14'
'/demo/dbdevops/target/db/instace_class :: db.m5.large'
'/demo/dbdevops/target/db/max_allocated_storage :: 50'
'/demo/dbdevops/target/db/name :: demo-test'
'/demo/dbdevops/target/db/parameter_group_name :: default.postgres14'
'required_version = ">= 1.0.0"'
'/demo/dbdevops/target/db/port :: 5432'
'/demo/dbdevops/target/db/secret_mgr_name :: demo-secret-manager-name'
'/demo/dbdevops/target/db/sg_ports :: [5432,443]'
'/demo/dbdevops/target/db/ssl_mode :: require' 
'/demo/dbdevops/target/db/transit :: false'
'/demo/dbdevops/target/environment :: dev'
'/demo/dbdevops/target/from_db_port :: 5432'
'/demo/dbdevops/target/identifier :: demodb'
'/demo/dbdevops/target/infra/aws_account_id :: *****'
'/demo/dbdevops/target/infra/aws_region :: "us-east-2"'
'/demo/dbdevops/target/infra/cidr_blocks :: ["xx.xx.xx.xx/xx"]'
'/demo/dbdevops/target/infra/sg_id :: sg-xxxxxx'
'/demo/dbdevops/target/infra/subnet_ids :: ["subnet-xxxxxxx", "subnet-xxxxxxx"]'
'/demo/dbdevops/target/infra/vpc_id :: vpc-xxxxxxx'
'/demo/dbdevops/target/project_name :: demo'
'/demo/dbdevops/target/repo_branch :: "master"'
'/demo/dbdevops/target/repo_name :: "terraform-aws-db-infra-cicd"'
'/demo/dbdevops/target/to_db_port :: 5432'
)
READCOUNTER=0 
SUCCESSCOUNTER=0
FAILCOUNTER=0
FAILEDUPDATE=()
for ssmparameter in "${ssmparametervalues[@]}" ; do
    (( READCOUNTER++ ))
    arr=(${ssmparameter//"::"/ })
    echo "${arr[0]}"
    echo "${arr[1]}"
    aws ssm put-parameter \
    --name ${arr[0]} \
    --value ${arr[1]} \
    --overwrite \
    --region $region

    if [ $? -ne 0 ]
    then
    echo "Failed to update SSM parameter  ${arr[0]} "
    (( FAILCOUNTER++ ))
    FAILEDUPDATE+=(${arr[0]})
    else
    (( SUCCESSCOUNTER++ ))
    fi

done

echo "=========================================================="
echo "Execution Completed"
echo "Total SSM Pameters Read: ${READCOUNTER}"
echo "Total SSM Pameters Updated Successfully: ${SUCCESSCOUNTER}"
echo "Total SSM Pameters Update Failed: ${FAILCOUNTER}"
if [ ${FAILCOUNTER} -gt 0 ]
then
echo "Failed to update below SSM Parameters"
for failed in "${FAILEDUPDATE[@]}"
do
   echo "${failed}"
done
echo "Please review logs to fix the issue."
fi
echo "=========================================================="

