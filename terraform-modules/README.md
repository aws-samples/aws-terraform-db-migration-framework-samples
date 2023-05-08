# Terraform-Modules
Common Terraform Modules

## Table of contents
* [Introduction](#Introduction)
* [Available Modules](#Available Modules)
* [Module Reference](#Module Reference) 

## Introduction

This repo contains the AWS Services Modules required to create the Infrastructure which are referenced in the below folders.

- db-cicd-integration
- db-validation
- db-provisioning
- db-dms

## Available Modules
Below are the list of available modules present in this repository :

- codebuild
- codecommit
- codepipeline
- iam-role
- kms
- s3

## Module Reference 
User can refer the Modules in the terraform code, as per the below example :

``` 
module "example" = {
    source = "<path of the aws service module user want to create>"
}
```

