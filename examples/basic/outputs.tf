output "bucket" {
  value = module.bucket_notification.bucket
}

output "lambda_function_arn" {
  value = module.bucket_notification.lambda_function_arn
}
