## Title
Terraform-aws-db-provisioning-ci-cd

## Table of contents
 * [Overview](#overview)
 * [Prerequisites](#pre-requisites)
 * [db-iac-templates](#db-iac-templates)
 * [db-provisioning-code](#db-provisioning-code)
 * [Deployment](#deployment)


## Overview
Database-IAC-templates and database-provisioning-code are included in this module.It helps with database provisioning using Infrastructure as Code (IaC).

## Pre-requisites 
- [Active AWS account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/) 
- [Least privilege IAM policy](https://aws.amazon.com/blogs/security/techniques-for-writing-least-privilege-iam-policies/)
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [Terraform state management using S3](https://developer.hashicorp.com/terraform/language/settings/backends/s3)


## db-iac-templates
Terraform is an infrastructure-as-code (IaC) tool that simplifies the creating,updating,and versioning of infrastructure in a secure and repeatable manner.db-iac-templates consists terraform templates for creating DB-provisioning CodePipelines.
As a guide and ready-to-use terraform configurations,this would provide an overview of how to setup validation pipelines with end-to-end tests using AWS CodePipeline,AWS CodeBuild,AWS CodeCommit and terraform.

## db-provisioning-code
This [folder](./db-provisioning-code) contains the sample terraform code to provision the RDS database using db-provisioning pipeline.
SSM parametrs being fetched from the first step of this solution i.e. setup/db-ssm-params and used in `db-provisioning-code/BUILDSPEC_TEMPLATES`. Variable decalarion is done in `db-provisioning-code/variables.tf`.

Note: We have provided the sample RDS database provisioning using terraform. Please refer [RDS best practises](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_BestPractices.html) to provision customized RDS database.


## Deployment

- As per required input values, update `db-iac-templates/examples/terraform.tfvars`.
- The following are the deployment commands for creating pipelines in an AWS account.
    ```
    cd db-iac-templates/
    terrform init
    terraform plan --var-file=examples/terraform.tfvars
    terraform apply --var-file=examples/terraform.tfvars
    ```
- Monitor the "DB-Provisioning pipeline" Pipeline for updates.
- Before deploying changes, it will ask for manual approval, please approve it and let the pipeline continue.
