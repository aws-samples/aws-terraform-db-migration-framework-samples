resource "aws_iam_role" "codepipeline_role" {
  count              = var.create_new_role ? 1 : 0
  name               = "${var.codepipeline_iam_role_name}-${data.aws_region.current.id}"
  tags               = var.tags
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Effect": "Allow"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  path               = "/"
}

resource "aws_iam_policy" "codepipeline_policy" {
  count       = var.create_new_role ? 1 : 0
  name        = "${var.project_name}-codepipeline-policy-${data.aws_region.current.id}"
  description = "Policy to allow codepipeline to execute"
  tags        = var.tags
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect":"Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:PutObjectAcl",
        "s3:PutObject",
        "s3:GetBucketVersioning"
      ],
      "Resource": ["${var.s3_bucket_arn}/*",
                  "${var.s3_bucket_arn}",
                  "arn:aws:s3:::*devops*",
                  "arn:aws:s3:::*devops*/*"]
    },
    {
      "Effect": "Allow",
      "Action": [
         "kms:DescribeKey",
         "kms:GenerateDataKey*",
         "kms:Encrypt",
         "kms:ReEncrypt*",
         "kms:Decrypt",
         "kms:Get*",
         "kms:List*",
         "kms:Describe*"
      ],
      "Resource": "arn:aws:kms:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:key/*"
    },
    {
      "Effect": "Allow",
      "Action": [
         "codecommit:GitPull",
         "codecommit:GitPush",
         "codecommit:GetBranch",
         "codecommit:CreateCommit",
         "codecommit:ListRepositories",
         "codecommit:BatchGetCommits",
         "codecommit:BatchGetRepositories",
         "codecommit:GetCommit",
         "codecommit:GetRepository",
         "codecommit:GetUploadArchiveStatus",
         "codecommit:ListBranches",
         "codecommit:UploadArchive"
      ],
      "Resource": "arn:aws:codecommit:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:${var.source_repository_name}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild",
        "codebuild:BatchGetProjects"
      ],
      "Resource": "arn:aws:codebuild:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:project/${var.project_name}*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "secretsmanager:GetSecretValue"
      ],
      "Resource": "arn:aws:secretsmanager:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:secret:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ssm:Get*",
        "ssm:List*",
        "ssm:Describe*"
      ],
      "Resource": "arn:aws:ssm:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:parameter/demo/dbdevops/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "rds:Describe*",
        "rds:StartDBCluster",
        "rds:CreateDBSubnetGroup",
        "rds:CreateDBInstance",
        "rds:ModifyDBInstance",
        "rds:DeleteDBCluster",
        "rds:DeleteDBInstance",
        "rds:CreateCustomDBEngineVersion",
        "rds:CreateDBClusterEndpoint",
        "rds:StopDBCluster",
        "rds:CreateDBParameterGroup",
        "rds:DeleteDBSnapshot",
        "rds:StopDBInstance",
        "rds:StartDBInstance",
        "rds:RebootDBCluster",
        "rds:ModifyDBSnapshot",
        "rds:DeleteDBSubnetGroup",
        "rds:ModifyCertificates",
        "rds:CreateDBSecurityGroup",
        "rds:CreateDBSnapshot",
        "rds:RebootDBInstance",
        "rds:CreateDBCluster",
        "rds:DeleteDBSecurityGroup",
        "rds:ModifyDBCluster",
        "rds:CreateDBClusterParameterGroup",
        "rds:ModifyDBSnapshotAttribute",
        "rds:CreateDBInstanceReadReplica",
        "rds:ModifyDBSubnetGroup"
      ],
      "Resource": "arn:aws:rds:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:db:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codepipeline:PollForJobs",
        "codepipeline:ListWebhooks",
        "codepipeline:ListPipelineExecutions",
        "codepipeline:StartPipelineExecution",
        "codepipeline:CreatePipeline",
        "codepipeline:PutJobSuccessResult",
        "codepipeline:DeletePipeline",
        "codepipeline:GetJobDetails",
        "codepipeline:TagResource",
        "codepipeline:PutApprovalResult",
        "codepipeline:PutJobFailureResult",
        "codepipeline:StopPipelineExecution",
        "codepipeline:ListPipelines",
        "codepipeline:GetPipeline",
        "codepipeline:AcknowledgeJob",
        "codepipeline:UntagResource",
        "codepipeline:UpdatePipeline",
        "codepipeline:GetPipelineState",
        "codepipeline:GetPipelineExecution"
      ],
      "Resource": "arn:aws:codepipeline:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:CreateReportGroup",
        "codebuild:CreateReport",
        "codebuild:UpdateReport",
        "codebuild:BatchPutTestCases"
      ],
      "Resource": "arn:aws:codebuild:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:report-group/${var.project_name}*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:log-group:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "dms:Describe*",
        "dms:List*",
        "dms:DeleteEndpoint",
        "dms:CreateEndpoint"
      ],
      "Resource": [
        "arn:aws:dms:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:rep:*",
        "arn:aws:dms:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:endpoint:*"]
    },
     {
      "Effect": "Allow",
      "Action": [
         "ec2:DescribeSecurityGroupRules",
                "ec2:DescribeVpcs",
                "ec2:DescribeSubnets",
                "ec2:DescribeSecurityGroups"
      ],
      "Resource": ["arn:aws:ec2:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:vpc/*",
              "arn:aws:ec2:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:subnet/*",
              "arn:aws:ec2:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:security-group/*",
              "arn:aws:ec2:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:security-group-rule/*"]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "codepipeline_role_attach" {
  count      = var.create_new_role ? 1 : 0
  role       = aws_iam_role.codepipeline_role[0].name
  policy_arn = aws_iam_policy.codepipeline_policy[0].arn
}