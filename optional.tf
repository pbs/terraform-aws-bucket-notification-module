variable "lambda_function_configurations" {
  description = "List of lambda function configurations"
  type = list(object({
    id            = optional(string)
    lambda_arn    = string
    events        = list(string)
    filter_prefix = optional(string)
    filter_suffix = optional(string)
  }))
}
