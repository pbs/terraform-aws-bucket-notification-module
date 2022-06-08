output "bucket" {
  description = "Bucket sending notifications"
  value       = aws_s3_bucket_notification.bucket_notification.bucket
}

output "lambda_function_arn" {
  description = "ARN of the lambda function invoked by the notification"
  value       = aws_s3_bucket_notification.bucket_notification.lambda_function[0].lambda_function_arn
}
