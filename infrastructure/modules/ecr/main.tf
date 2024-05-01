# Private ECR Repository
resource "aws_ecr_repository" "image" {
  name         = "${var.default_tags.Project}-${var.default_tags.Environment}-image-repo"
  force_delete = true
}

resource "aws_ecr_repository" "chart" {
  name         = "${var.default_tags.Project}-${var.default_tags.Environment}-chart-repo"
  force_delete = true
}

# Github actions role (push image and chart to ECR)
data "aws_iam_policy_document" "ga-assumerole" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [var.github_account_id]
    }
  }
}

resource "aws_iam_role" "github-actions" {
  name                = "${var.default_tags.Project}-${var.default_tags.Environment}-GithubActionsRole"
  assume_role_policy  = data.aws_iam_policy_document.ga-assumerole.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"]
}