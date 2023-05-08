## Title
terraform-aws-db-dms-ci-cd

## Table of contents
 * [Overview](#overview)
 * [Pre-requisites](#pre-requisites)
 * [db-dms-iac-templates](#db-dms-iac-templates)
 * [db-dms-code](#db-dms-code)
 * [Deployment](#deployment)

## Overview
The folder consists of db-dbms-iac-templates and db-dms-code. Which helps to provision the DMS using Infrastructure as code (IaC).

## Pre-requisites 
- [Active AWS account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/) 
- [Least privilege IAM policy](https://aws.amazon.com/blogs/security/techniques-for-writing-least-privilege-iam-policies/)
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [Terraform state management using S3](https://developer.hashicorp.com/terraform/language/settings/backends/s3)

## db-dms-iac-templates
db-dms-iac-templates consists the terraform templates for creating DB-DMS CodePipeline.
Terraform is an infrastructure-as-code (IaC) tool that simplifies the creating,updating,and versioning of infrastructure in a secure and repeatable manner.db-iac-templates consists terraform templates for creating DB-provisioning CodePipelines.
As a guide and ready-to-use terraform configurations,this would provide an overview of how to setup validation pipelines with end-to-end tests using AWS CodePipeline,AWS CodeBuild,AWS CodeCommit and terraform.

## db-dms-code
db-dms-code consists the terraform templates for creating DB-DMS Infra.Update`db-dms-iac-templates/examples/terraform.tfvars` as per the user requirements.
The parameters required for the DMS setup is stored in AWS SSM and the `db-dms/db-dms-code/BUILDSPEC_TEMPLATES` folder is configured to fetch the SSM parameter for the variables used in the `variable.tf` files present in `db-dms/db-dms-code/dms/Infra/variable.tf`.

## Deployment
- As per required input values, update db-dms-iac-templates/examples/terraform.tfvars.
- The following are the deployment commands for creating pipelines in an AWS account.

```
$ cd db-dms-iac-templates/
$ terrform init
$ terraform plan --var-file=examples/terraform.tfvars
$ terraform apply --var-file=examples/terraform.tfvars 

```
- Monitor the "DB-DMS pipeline" Pipeline for updates.
- Before deploying changes, it will ask for manual approval, please approve it and let the pipeline continue.
