# terraform-aws-db-validation

## Name
Database Validation

## Description
This Module helps in Validating some pre-requisties which are required for the db-migration project, using Infrastructure as code (IaC).

## Table of contents
CONTENTS OF THIS FILE
---------------------

 * Introduction
 * Pre-Requisites
 * Scope
 * Troubleshooting/FAQ
 * Maintainers

## Introduction
These validcation checks will be performed on source database, tagert infrasturcture and connectivity of source database hosted on-premise or cloud.
Current solution performs below validation checks using AWS CI/CD services like CodeCommit, CodePipeline and CodeBuild : 
- Target AWS Account configuration
- Source database
- Target Infrastructure
- Target database configuration
- Network connectivity

These validation checks will help in preventing the errors before real migration activity starts and it will also helps in reducing the downtime required for migration activity to complete.

## Pre-Requisites
Pre-requisites specific for DB validation repo:-
- Target VPC should be created
- Private subnets should be already created where target database will be provisioned
- Route Tables for Private subnets are configured
- Security Groups which will be attached to target should be configured 
- Source database endpoint and credentials(username, password, db_endpoint, db_port) should be present in SSM Parameter store
- On-premise is connected with AWS VPC either using AWS Direct Connect or AWS Site to Site VPN

Below are few input parameters identified for automated validation pipeline :
| Input Name | Description |
|------------|-------------|
|accountId |	Targeted AWS account id |
|region |	Target account region |
|sourceDbType |	Source database type (ex. postgres, mysql, etc.) |
|sourceDBVersion |	Source database Version |
|sourceDBEndpointSSMParam	| Source database endpoint SSM parameter name |
|sourceDBPortSSMParam |	Source database port SSM parameter name |
|sourceDBUsernameSSMParam	| Source database username SSM parameter name |
|sourceDBPasswordSSMParam |	Source database password SSM parameter name |
|targetDBVpcId |	Target database vpc id|
|targetDBSubnetId |	Target database subnet id |
|targetDBSecurityGroupId |	Target database security group id |
|targetDBType |	Target database type |
|targetDBVersion	 | Target database version |

## Scope
- Source database endpoint connectivity
- Validate if provided AWS account available
- Check if provided VPC and subnets exists for target
- Check if mentioned security groups for target DB are present
- Check if secrets for database already present in parameter store
***