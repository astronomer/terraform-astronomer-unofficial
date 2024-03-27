# Astro Token
variable "AUTH_TOKEN" {
  description = "<your-token>"
  type        = string
}

variable "iam_api_url" {
  default     = "https://api.astronomer.io/iam/v1beta1"
  description = "value"
  type        = string
}

variable "platform_api_url" {
  default     = "https://api.astronomer.io/platform/v1beta1"
  description = "value"
  type        = string
}
