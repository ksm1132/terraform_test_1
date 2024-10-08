resource "aws_codebuild_project" "continuous_apply" {
  name         = "continuous-apply"
  service_role = module.continuous_apply_codebuild_role.iam_role_arn

  source {
    type     = "GITHUB"
    location = "https://github.com/ksm1132/terraform_test_1.git"
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "hashicorp/terraform0.12.5"
    type            = "LINUX_CONTAINER"
    privileged_mode = false

  }

  provisioner "local-exec" {
    command = <<EOT
      set GITHUB_TOKEN=${data.aws_ssm_parameter.github_token.value} && aws codebuild import-source-credentials --server-type GITHUB --auth-type PERSONAL_ACCESS_TOKEN --token $GITHUB_TOKEN
EOT
  }
}

data "aws_ssm_parameter" "github_token" {
  name = "/continuous_apply/github_token"
}

