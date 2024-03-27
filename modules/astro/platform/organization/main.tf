terraform {
  required_providers {
    restapi = {
      source  = "Mastercard/restapi"
      version = "1.18.2"
    }
  }
}

# ORGANIZATION
data "restapi_object" "organization" {
  path         = "/organizations"
  results_key  = "organizations"
  search_key   = "id"
  search_value = var.organization_id
}
