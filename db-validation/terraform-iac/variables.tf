variable "repository_name" {
  type    = string
  default = "db-migration-devops"
}

variable "repository_branch" {
  type    = string
  default = "main"
}

variable "build_project_source" {
  type    = string
  default = "CODECOMMIT"
}

variable "builder_compute_type" {
  type    = string
  default = "BUILD_GENERAL1_SMALL"
}
variable "builder_image" {
  type    = string
  default = "aws/codebuild/standard:5.0"
}
variable "builder_image_pull_credentials_type" {
  type    = string
  default = "CODEBUILD"
}
variable "build_project_artifact_type" {
  type    = string
  default = "NO_ARTIFACTS"
}

variable "builder_type" {
  type    = string
  default = "LINUX_CONTAINER"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "project_name" {
  type    = string
  default = "db-validation"
}

variable "build_timeout" {
  type    = number
  default = 60
}

variable "build_projects" {
  type    = list(string)
  default = ["account", "db_connect", "db_params", "sgs", "vpc_subnets"]
}

variable "create_new_role" {
  description = "Whether to create a new IAM Role. Values are true or false. Defaulted to true always."
  type        = bool
  default     = true
}

variable "codepipeline_iam_role_name" {
  description = "Name of the IAM role to be used by the Codepipeline"
  type        = string
  default     = "codepipeline-role"
}

variable "buildspecyaml_directory" {
  description = "buildspec yaml file location"
  type        = string
}

variable "source_repo_name" {
  description = "Source repo name of the CodeCommit repository"
  type        = string
}

variable "source_repo_branch" {
  description = "Default branch in the Source repo for which CodePipeline needs to be configured"
  type        = string
}