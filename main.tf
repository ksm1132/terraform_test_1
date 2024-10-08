provider "aws" {
  region     = "ap-northeast-1"  # 適切なリージョンを指定
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "describe_regions_for_ec2" {
  source = "./iam_role"
  name = "describe-regions-for-ec2"
  identifier = "ec2.amazonaws.com"
  policy = data.aws_iam_policy_document.allow_describe_regions.json
}

data "aws_iam_policy_document" "allow_describe_regions" {
  statement {
    actions = ["ec2:DescribeRegions"]

    resources = ["*"]
  }
}

module "continuous_apply_codebuild_role" {
  source = "./iam_role"
  name = "continuous-apply"
  identifier = "codebuild.amazonaws.com"
  policy = data.aws_iam_policy.administrator_access.policy
}

data "aws_iam_policy" "administrator_access" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


