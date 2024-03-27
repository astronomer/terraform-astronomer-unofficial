variable "organization_id" {
  description = "The ID of the Organization where you want to create the token."
  type        = string
}

variable "name" {
  description = "The name of the API token."
  type        = string
}

variable "role" {
  description = "The role of the API token."
  type        = string
  validation {
    condition     = contains(["DEPLOYMENT_ADMIN", "WORKSPACE_OWNER", "WORKSPACE_OPERATOR", "WORKSPACE_AUTHOR", "WORKSPACE_MEMBER", "WORKSPACE_ACCESSOR", "ORGANIZATION_OWNER", "ORGANIZATION_BILLING_ADMIN", "ORGANIZATION_MEMBER"], var.role)
    error_message = "Invalid value for role."
  }
}

variable "type" {
  description = "The scope of the API token."
  type        = string
  validation {
    condition     = contains(["WORKSPACE", "ORGANIZATION", "DEPLOYMENT"], var.type)
    error_message = "Invalid value for type. Must be one of ['WORKSPACE', 'ORGANIZATION', 'DEPLOYMENT']"
  }
}

variable "description" {
  description = "The description for the API token."
  type        = string
}

variable "entity_id" {
  description = "The ID of the Workspace to which the API token is scoped."
  type        = string
}

variable "expiry_period_days" {
  description = "The expiry period of the API token in days. If not specified, the token will never expire."
  type        = number
  default     = 30
  nullable    = true
  validation {
    condition = (
      var.expiry_period_days == null ||
      can((ceil(var.expiry_period_days) == floor(var.expiry_period_days))) &&
      can(var.expiry_period_days >= 1 && var.expiry_period_days <= 3650)
    )
    error_message = "Invalid value for expiry_period_days. Value must be an integer between 1 and 3650."
  }
}
