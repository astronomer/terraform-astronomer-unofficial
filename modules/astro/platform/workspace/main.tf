terraform {
  required_providers {
    restapi = {
      source  = "Mastercard/restapi"
      version = "1.18.2"
    }
  }
}

resource "restapi_object" "workspace" {
  path = "/organizations/${var.organization_id}/workspaces"
  data = jsonencode(
    {
      "name" : "${var.name}"
      "description" : "${var.description}",
      "cicdEnforcedDefault" : "${var.enforce_cicd}",
  })
}
