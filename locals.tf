locals {
  # These must be copied from the Astro UI
  organization_id = "<your_org_id>"
  cluster_id      = "<your_hybrid_cluster_id>"

  # We assume these were created by SCIM and already exist in your Org
  # The name must be copied from the Astro UI.
  organization_teams = [
    {
      "name" : "<your_scim_team_1>",
    },
    {
      "name" : "<your_scim_team_2>",
    }
  ]

  # Provide the Workspaces and Deployments information below
  workspaces = [
    {
      "name" : "Terraform Test Workspace Team 1",
      "description" : "Terraform team 1",
      "enforce_cicd" : true,
      "deployments" : [
        {
          "name" : "Terraform Test Deployment Team 1 DEV",
          "description" : "DEV Deployment created with Terraform",
          "astro_runtime_version" : "10.2.0",
          "executor" : "CELERY",
          "contact_emails" : ["olivier.daneau@astronomer.io"],
          "api_token" : {
            "name" : "CICD Team 1 DEV",
            "role" : "DEPLOYMENT_ADMIN",
            "type" : "DEPLOYMENT",
            "description" : "CI/CD API Token Team 1 DEV",
            "expiry_period_days" : null,
          }
        },
        {
          "name" : "Terraform Test Deployment Team 1 PROD",
          "description" : "PROD Deployment created with Terraform",
          "astro_runtime_version" : "10.2.0",
          "executor" : "CELERY",
          "contact_emails" : ["olivier.daneau@astronomer.io"],
          "api_token" : {
            "name" : "CICD Team 1 PROD",
            "role" : "DEPLOYMENT_ADMIN",
            "type" : "DEPLOYMENT",
            "description" : "CI/CD API Token Team 1 PROD",
            "expiry_period_days" : null,
          }
        }
      ]
    },
    {
      "name" : "Terraform Test Workspace Team 2",
      "description" : "Terraform team 2",
      "enforce_cicd" : true,
      "deployments" : [
        {
          "name" : "Terraform Test Deployment Team 2 DEV",
          "description" : "DEV Deployment created with Terraform",
          "astro_runtime_version" : "10.2.0",
          "executor" : "CELERY",
          contact_emails : ["olivier.daneau@astronomer.io"],
          "api_token" : {
            "name" : "CICD Team 2 DEV",
            "role" : "DEPLOYMENT_ADMIN",
            "type" : "DEPLOYMENT",
            "description" : "CI/CD API Token Team 2 DEV",
            "expiry_period_days" : null,
          }
        }
      ]
    }
  ]
}
