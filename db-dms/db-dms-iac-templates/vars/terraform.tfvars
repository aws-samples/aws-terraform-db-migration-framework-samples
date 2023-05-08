project_name       = "db-dms"
environment        = "dev"
source_repo_name   = "db-migration-devops"
pipelinename       = "db-dms-pipeline"
source_repo_branch = "main"
create_new_repo    = false
repo_approvers_arn = "arn:aws:sts::xxxxxx:assumed-role/CodeCommitReview/*" #Update ARN (IAM Role/User/Group) of Approval Members
create_new_role    = true
#codepipeline_iam_role_name = <Role name> - Use this to specify the role name to be used by codepipeline if the create_new_role flag is set to false.
stage_input = [
  { stage_name = "Linting", name = "tflint", category = "Test", owner = "AWS", provider = "CodeBuild",env  = "dms", input_artifacts = "SourceOutput", output_artifacts = "tflintOutput" },
  { stage_name = "Static-Code-Analysis", name = "checkov", category = "Test", owner = "AWS", provider = "CodeBuild",env  = "dms", input_artifacts = "SourceOutput", output_artifacts = "checkovOutput" },
  { stage_name = "Readme-File-Generation", name = "tdocs", category = "Build", owner = "AWS", provider = "CodeBuild",env  = "dms", input_artifacts = "SourceOutput", output_artifacts = "teradocOutput" },
  { stage_name = "Code-Formatting-Plan", name = "tfplan", category = "Build", owner = "AWS", provider = "CodeBuild",env  = "dms", input_artifacts = "SourceOutput", output_artifacts = "ApplyOutput" },
  { stage_name = "Approve", category = "Approval", owner = "AWS", provider = "Manual", input_artifacts = "",env  = "dms", output_artifacts = "" },
  { stage_name = "Implementation",name = "tfapply", category = "Build", owner = "AWS", provider = "CodeBuild",env  = "dms", input_artifacts = "ApplyOutput", output_artifacts = "DestroyOutput" }
]
build_projects = ["tflint", "checkov", "infracost", "tdocs", "tfplan", "tfapply"]
backend_s3_bucket_name = "{{backend-bucket-name}}"
buildspecyaml_directory = "db-dms/db-dms-code/BUILDSPEC_TEMPLATES"