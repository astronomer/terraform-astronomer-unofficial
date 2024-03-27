variable "organization_id" {
  description = "The ID of the Organization where you want to create the token."
  type        = string
}

variable "cluster_id" {
  description = "The cluster's ID."
  type        = string
}

variable "workspace_id" {
  description = "The ID of the workspace to which the Deployment belongs."
  type        = string
}

variable "name" {
  description = "The Deployment's name."
  type        = string
  validation {
    condition     = length(var.name) <= 500
    error_message = "Name must be 500 characters or less"
  }
}

variable "description" {
  description = "The Deployment's description."
  type        = string
  validation {
    condition     = length(var.description) <= 1000
    error_message = "Name must be 1000 characters or less"
  }
}

variable "astro_runtime_version" {
  type        = string
  description = "The Astro Runtime version for the Deployment."
  default     = "9.1.0"
  validation {
    condition     = can(regex("^(\\d+\\.\\d+\\.\\d+)$", var.astro_runtime_version))
    error_message = "Major, minor, and patch versions must be specified."
  }
}

variable "is_dag_deploy_enabled" {
  type    = bool
  default = true
}

variable "executor" {
  type    = string
  default = "CELERY"
  validation {
    condition     = contains(["CELERY", "KUBERNETES"], var.executor)
    error_message = "Valid value is one of the following: 'CELERY', 'KUBERNETES'."
  }
}

variable "scheduler_au" {
  type    = number
  default = 5
  validation {
    condition     = var.scheduler_au >= 5 && var.scheduler_au <= 24
    error_message = "Value must be an integer between 5 and 24."
  }
}

variable "scheduler_count" {
  type    = number
  default = 1
  validation {
    condition     = var.scheduler_count >= 1 && var.scheduler_count <= 4
    error_message = "Value must be an integer between 1 and 4."
  }
}

variable "is_ci_cd_enforced" {
  type    = bool
  default = true
}

variable "max_worker_count" {
  type    = number
  default = 10
  validation {
    condition     = var.max_worker_count >= 1 && var.max_worker_count <= 30
    error_message = "Value must be an integer between 1 and 30."
  }
}

variable "min_worker_count" {
  type    = number
  default = 0
  validation {
    condition     = var.min_worker_count >= 0 && var.min_worker_count <= 30
    error_message = "Value must be an integer between 0 and 30."
  }
}

variable "worker_concurrency" {
  type    = number
  default = 16
  validation {
    condition     = var.worker_concurrency >= 1 && var.worker_concurrency <= 64
    error_message = "Value must be an integer between 1 and 64."
  }
}

variable "node_pool_id" {
  type        = string
  description = "The node pool ID associated with the worker queue. For Astro Hybrid only."
}

variable "contact_emails" {
  type        = list(string)
  description = "A list of contact emails for the Deployment."
}

variable "environment_variables" {
  type = list(object({
    isSecret = bool
    key      = string
    value    = string
  }))
  description = "List of environment variables to add to the Deployment."
}
