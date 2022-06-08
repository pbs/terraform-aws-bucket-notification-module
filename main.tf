resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = var.bucket

  lambda_function {
    lambda_function_arn = var.lambda_arn
    events              = var.events
    filter_prefix       = var.filter_prefix
    filter_suffix       = var.filter_suffix
  }
}
