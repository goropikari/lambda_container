terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_ecr_repository" "lambda_containter" {
  name = "lambda_container"
}

# Comment out after making ECR and IAM.
# resource "aws_lambda_function" "lambda_container" {
#   function_name = "lambda_container"
#   role          = aws_iam_role.lambda_container.arn
#   package_type  = "Image"
#   image_uri     = "${aws_ecr_repository.lambda_containter.repository_url}:v1"
#   timeout       = 60
#
#   lifecycle {
#     ignore_changes = [image_uri]
#   }
# }

resource "aws_iam_role" "lambda_container" {
  name = "lambda_container"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_container" {
  role       = aws_iam_role.lambda_container.name
  policy_arn = aws_iam_policy.lambda-cloudwatch-access.arn
}

resource "aws_iam_policy" "lambda-cloudwatch-access" {
  name   = "lambda-cloudwatch-access"
  policy = data.aws_iam_policy_document.lambda-cloudwatch-access.json
}

data "aws_iam_policy_document" "lambda-cloudwatch-access" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "*",
    ]
  }
}
