terraform {
  required_providers {
    restapi = {
      source  = "Mastercard/restapi"
      version = "1.18.2"
    }
  }
}

locals {
  api_decoded_response = jsondecode(resource.restapi_object.api_token.create_response)
}

resource "restapi_object" "api_token" {
  path = "/organizations/${var.organization_id}/tokens"
  data = jsonencode(
    {
      "name" : "${var.name}",
      "role" : "${var.role}",
      "type" : "${var.type}",
      "description" : "${var.description}",
      "entityId" : "${var.entity_id}",
      "tokenExpiryPeriodInDays" : "${var.expiry_period_days}",
    }
  )
}
