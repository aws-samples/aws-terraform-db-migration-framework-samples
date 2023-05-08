resource "aws_codepipeline" "db-validation-pipeline" {
  name     = "db-validation-pipeline"
  role_arn = module.codepipeline_iam_role.role_arn


  artifact_store {
    location = module.s3_artifacts_bucket.bucket
    type     = "S3"
    encryption_key {
      id   = module.codepipeline_kms.arn
      type = "KMS"
    }
  }
  stage {
    name = "Source"

    action {
      name             = "Source"
      namespace        = "SourceVariables"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["SourceArtifact"]
      input_artifacts  = []

      configuration = {
        "RepositoryName"       = var.repository_name
        BranchName             = var.repository_branch
        "OutputArtifactFormat" = "CODE_ZIP"
        "OutputArtifactFormat" = "CODE_ZIP"
        "PollForSourceChanges" = "false"
      }


    }
  }
  stage {
    name = "Account_Validation"

    action {
      name             = module.validate.name[0]
      namespace        = "Account_Validation"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["AccountArtifact"]
      version          = "1"

      configuration = {
        "ProjectName" = module.validate.name[0]
      }
    }
  }
  stage {
    name = "Validate_Infrastructure"

    action {
      name             = module.validate.name[4]
      namespace        = "Validate_Infrastructure_VPC"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["InfraArtifactNetwork"]
      version          = "1"

      configuration = {
        "ProjectName" = module.validate.name[4]
      }
    }
    action {
      name             = module.validate.name[3]
      namespace        = "Validate_Infrastructure_SG"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["InfraArtifactSG"]
      version          = "1"

      configuration = {
        "ProjectName" = module.validate.name[3]
      }
    }
  }
  stage {
    name = "Validate_Source_Database"

    action {
      name             = module.validate.name[1]
      namespace        = "Validate_Source_Database_Reachability"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["SourceDBArtifactRechability"]
      version          = "1"

      configuration = {
        "ProjectName" = module.validate.name[1]
      }
    }
    action {
      name             = module.validate.name[2]
      namespace        = "Validate_Source_Database_Params"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["SourceDBArtifactParams"]
      version          = "1"

      configuration = {
        "ProjectName" = module.validate.name[2]
      }
    }
  }
}
