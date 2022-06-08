variable "bucket" {
  description = "Bucket to attach notifications to"
  type        = string
}

variable "lambda_arn" {
  description = "ARN of the lambda to invoke"
  type        = string
}
