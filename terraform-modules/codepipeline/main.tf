resource "aws_codepipeline" "terraform_pipeline" {

  name     = var.pipelinename
  role_arn = var.codepipeline_role_arn
  tags     = var.tags

  artifact_store {
    location = var.s3_bucket_name
    type     = "S3"
    encryption_key {
      id   = var.kms_key_arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Download-Source"
      category         = "Source"
      owner            = "AWS"
      version          = "1"
      provider         = "CodeCommit"
      namespace        = "SourceVariables"
      output_artifacts = ["SourceOutput"]
      run_order        = 1

      configuration = {
        RepositoryName       = var.source_repo_name
        BranchName           = var.source_repo_branch
        PollForSourceChanges = "false"
      }
    }
  }

  dynamic "stage" {
    for_each = var.stages

    content {
      name = stage.value["stage_name"]
      action {
        category         = stage.value["category"]
        name             = stage.value["stage_name"]
        owner            = stage.value["owner"]
        provider         = stage.value["provider"]
        input_artifacts  = [stage.value["provider"] == "CodeBuild" ? stage.value["input_artifacts"] : ""]
        output_artifacts = [stage.value["provider"] == "CodeBuild" ? stage.value["output_artifacts"] : ""]
        version          = "1"
        run_order        = index(var.stages, stage.value) + 2

        configuration = {
          ProjectName = stage.value["provider"] == "CodeBuild" ? "${var.project_name}-${stage.value["name"]}" : null
          CustomData  = stage.value["provider"] == "Manual" ? "${var.approve_comment}" : null
          EnvironmentVariables = stage.value["env"] == "integration" ? jsonencode([
            {
              name  = "PipelineName"
              value = stage.value["PipelineName"]
              type  = "PLAINTEXT"
            },
            {
              name  = "sleeptime"
              value = stage.value["sleeptime"]
              type  = "PLAINTEXT"
            }
          ]) : null
        }
      }
    }
  }
}
