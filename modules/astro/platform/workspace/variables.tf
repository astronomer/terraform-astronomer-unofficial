variable "organization_id" {
  description = "The ID of the Organization where you want to create the token."
  type        = string
}

variable "name" {
  description = "The name for the Workspace."
  type        = string
}

variable "description" {
  default = "The description for the Workspace."
  type    = string
}

variable "enforce_cicd" {
  description = "Determines whether users are required to use a Workspace API token or Deployment API key to deploy code."
  type        = bool
  default     = true
}
