variable "events" {
  description = "Event to notify on"
  default     = ["s3:ObjectCreated:*"]
  type        = list(string)
}

variable "filter_prefix" {
  description = "Prefix this notification should apply to"
  default     = null
  type        = string
}

variable "filter_suffix" {
  description = "Suffix this notification should apply to"
  default     = null
  type        = string
}
