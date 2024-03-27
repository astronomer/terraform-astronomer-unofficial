terraform {
  required_providers {
    restapi = {
      source  = "Mastercard/restapi"
      version = "1.18.2"
    }
  }
}

# Assuming Teams are configured by SSO + SCIM, we fetch them as Read-only
data "restapi_object" "team" {
  path         = "/organizations/${var.organization_id}/teams"
  results_key  = "teams"
  search_key   = "name"
  search_value = var.name
}
