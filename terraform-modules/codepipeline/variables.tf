variable "project_name" {
  description = "Unique name for this project"
  type        = string
}

variable "environment_variable_map" {
  type = list(object({
    name  = string
    value = string
    type  = string
  }))
  default     = []
  description = "Additional environment variables for the build process. The type of environment variable. Valid values: PARAMETER_STORE, PLAINTEXT, and SECRETS_MANAGER."
}

variable "pipelinename" {
  description = "Unique name for this project"
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

variable "s3_bucket_name" {
  description = "S3 bucket name to be used for storing the artifacts"
  type        = string
}

variable "codepipeline_role_arn" {
  description = "ARN of the codepipeline IAM role"
  type        = string
}

variable "kms_key_arn" {
  description = "ARN of KMS key for encryption"
  type        = string
}

variable "tags" {
  description = "Tags to be attached to the CodePipeline"
  type        = map(any)
}

variable "stages" {
  description = "List of Map containing information about the stages of the CodePipeline"
  type        = list(map(any))
}

variable "approve_comment" {
  description = "List of Map containing information about the stages of the CodePipeline"
  type        = string
}
