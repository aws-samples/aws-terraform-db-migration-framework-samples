project_name       = "db-provisioning"
pipelinename       = "db-provisioning-pipeline"
environment        = "dev"
source_repo_name   = "db-migration-devops"
source_repo_branch = "main"
create_new_repo    = false
repo_approvers_arn = "arn:aws:sts::xxxxxxx:assumed-role/CodeCommitReview/*" #Update ARN (IAM Role/User/Group) of Approval Members
create_new_role    = true
#codepipeline_iam_role_name = <Role name> - Use this to specify the role name to be used by codepipeline if the create_new_role flag is set to false.
stage_input = [
  { stage_name = "Pre-Checks", name = "checklist", category = "Test", owner = "AWS", provider = "CodeBuild",env  = "provisioning", input_artifacts = "SourceOutput", output_artifacts = "ValidateOutput" },
  { stage_name = "Cost-Estimation", name = "infracost", category = "Test", owner = "AWS", provider = "CodeBuild",env  = "provisioning", input_artifacts = "SourceOutput", output_artifacts = "PlanOutput" },
  { stage_name = "Plan-of-Action", name = "plan", category = "Build", owner = "AWS", provider = "CodeBuild",env  = "provisioning", input_artifacts = "SourceOutput", output_artifacts = "ApplyOutput" },
  { stage_name = "Approve", category = "Approval", owner = "AWS", provider = "Manual", input_artifacts = "",env  = "provisioning", output_artifacts = "" },
  { stage_name = "Implementation",name = "apply", category = "Build", owner = "AWS", provider = "CodeBuild",env  = "provisioning", input_artifacts = "ApplyOutput", output_artifacts = "DestroyOutput" }
]
build_projects = ["checklist", "infracost", "plan", "apply"]
buildspecyaml_directory = "db-provisioning/db-provisioning-code/BUILDSPEC_TEMPLATES"
