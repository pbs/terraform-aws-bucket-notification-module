data "aws_iam_policy_document" "policy_doc" {
  statement {
    actions = [
      "logs:PutLogEvents",
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "kms:Get*",
      "kms:List*",
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords",
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "${module.s3.arn}/*"
    ]
  }
}

module "lambda" {
  source = "github.com/pbs/terraform-aws-lambda-module?ref=1.3.2"

  name = "ex-tf-bucket-notif"

  handler  = "lambda_handler.lambda_handler"
  filename = "../src/lambda_handler.zip"
  runtime  = "python3.8"

  policy_json = data.aws_iam_policy_document.policy_doc.json

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}

module "s3" {
  source = "github.com/pbs/terraform-aws-s3-module?ref=1.0.3"

  name = "ex-tf-bucket-notif"

  force_destroy = true

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}

module "bucket_notification" {
  source = "../.."

  bucket = module.s3.name

  lambda_function_configurations = [{
    id            = "test"
    lambda_arn    = module.lambda.arn
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "test"
    filter_suffix = ".gz"
  }]

  depends_on = [
    module.s3,
  ]
}

module "lambda_permission" {
  source = "github.com/pbs/terraform-aws-lambda-permission-module?ref=0.0.1"

  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.name
  principal     = "s3.amazonaws.com"
  source_arn    = module.s3.arn
}

resource "aws_s3_object" "object" {
  bucket = module.s3.name
  key    = "test/test.3001-01-01-01.test.gz"
  source = "../src/test.3001-01-01-01.test.gz"

  etag = filemd5("../src/test.3001-01-01-01.test.gz")

  depends_on = [
    module.bucket_notification,
    module.lambda_permission,
  ]
}
