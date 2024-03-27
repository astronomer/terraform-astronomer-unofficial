terraform {
  required_providers {
    restapi = {
      source  = "Mastercard/restapi"
      version = "1.18.2"
    }
  }
}

data "restapi_object" "cluster" {
  path         = "/organizations/${var.organization_id}/clusters"
  results_key  = "clusters"
  search_key   = "id"
  search_value = var.cluster_id
}

# This is needed because api_data does not correctly decode deeply nested objects.
locals {
  api_response = jsondecode(data.restapi_object.cluster.api_response)
}
