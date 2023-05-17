resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = var.bucket

  dynamic "lambda_function" {
    for_each = var.lambda_function_configurations
    content {
      id                  = lambda_function.value.id
      lambda_function_arn = lambda_function.value.lambda_arn
      events              = lambda_function.value.events
      filter_prefix       = lambda_function.value.filter_prefix
      filter_suffix       = lambda_function.value.filter_suffix
    }
  }
}
