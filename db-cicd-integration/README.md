## Title
Terraform-aws-db-cicd-integration

## Table of contents

 * [Overview](#Overview)
 * [Prerequisites](#prerequisites)
 * [terraform-iac](#terraform-iac)
 * [Deployment](#Deployment)

## Overview
This Module helps to execute the database migration pipelines from centralized pipeline.This cicd-integrated-pipeline is the centralized pipeline which will be used to trigger all the below child pipelines.

- db-validation-pipeline
- db-provisioning-pipeline
- db-dms-pipeline

## Prerequisites

- [Active AWS account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/) 
- [Least privilege IAM policy](https://aws.amazon.com/blogs/security/techniques-for-writing-least-privilege-iam-policies/)
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [Terraform state management using S3](https://developer.hashicorp.com/terraform/language/settings/backends/s3)

## terraform-iac
Terraform is an infrastructure-as-code (IaC) tool that simplifies the creating,updating,and versioning of infrastructure in a secure and repeatable manner.terraform-iac consists terraform templates for creating cicd-integration CodePipeline to trigger all the other child pipelines.
As a guide and ready-to-use terraform configurations,this would provide an overview of how to setup integration pipelines with end-to-end tests using AWS CodePipeline,AWS CodeBuild,AWS CodeCommit and terraform.

## Deployment

- Update the terraform.sample file as per required input values.
- Below are the deployment commands to create pipeline in AWS account.
    ```
    cd terraform-iac
    terraform init
    terraform plan --var-file=terraform.sample
    terraform apply --var-file=terraform.sample
    ```
- Click Release change for aws-devops-integrated-pipeline to start the pipeline
- Track the "aws-devops-integrated-pipeline" Pipeline for further update.
- It will ask for the manual approval before starting db-dms-pipeline , please approve it and let the run further stages of pipeline.

***

