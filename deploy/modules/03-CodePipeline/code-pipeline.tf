resource "aws_codepipeline" "code_pipeline" {
  name     = "${var.name_prefix}-${var.code_pipeline_name}${var.name_suffix}"
  role_arn = aws_iam_role.iam_role.arn

  artifact_store {
    location = var.bucket_id
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.codestarconnections_connection.arn
        FullRepositoryId = "jasonlll88/tf-s3-cloudfront-codepipeline"
        BranchName       = "main"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "S3"
      input_artifacts = ["SourceArtifact"]
      version         = "1"

      configuration = {
        BucketName       = var.bucket_id
        Extract          = "true"
      }
    }
  }
  stage {
    name = "Invalidate"

    action {
      name            = "Invalidate"
      category        = "Invoke"
      owner           = "AWS"
      provider        = "Lambda"
      version         = "1"

      configuration = {
        FunctionName       = local.lambda_function_name
        UserParameters     = jsonencode({
                              distributionId = "${var.distribution_id}"
                              objectPaths    = ["/*"]
                            })
      }
    }
  }

  tags = merge(local.tags,{Name = "${var.name_prefix}-${var.code_pipeline_name}${var.name_suffix}"})
}

resource "aws_iam_role" "iam_role" {
  name = "${var.name_prefix}-${var.code_pipeline_name}${var.name_suffix}-role"
  assume_role_policy = data.template_file.cp_trust_relationship.rendered

  tags = merge(local.tags,{Name = "${var.name_prefix}-${var.code_pipeline_name}${var.name_suffix}-role"})
}

resource "aws_iam_role_policy" "iam_role_policy" {
  name   = "${var.name_prefix}-${var.code_pipeline_name}${var.name_suffix}-policy"
  role       = aws_iam_role.iam_role.name
  policy = data.template_file.cp_policy.rendered
}

data "template_file" "cp_policy" {
  template = file("${path.module}/policies/code_pipeline_policy.json")
}

data "template_file" "cp_trust_relationship" {
  template = file("${path.module}/policies/code_pipeline_trust_relationship.json")
}

resource "aws_codestarconnections_connection" "codestarconnections_connection" {
  name          = "github-connection"
  provider_type = "GitHub"
}