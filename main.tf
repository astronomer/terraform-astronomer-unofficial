terraform {
  required_providers {
    restapi = {
      source  = "Mastercard/restapi"
      version = "1.18.2"
    }
  }
}

provider "restapi" {
  alias                = "platform"
  uri                  = "https://api.astronomer.io/platform/v1beta1"
  write_returns_object = true
  debug                = true

  headers = {
    "Authorization" = "Bearer ${var.AUTH_TOKEN}",
    "Content-Type"  = "application/json"
  }
}

provider "restapi" {
  alias                = "iam"
  uri                  = "https://api.astronomer.io/iam/v1beta1"
  write_returns_object = true
  debug                = true

  headers = {
    "Authorization" = "Bearer ${var.AUTH_TOKEN}",
    "Content-Type"  = "application/json"
  }
}

module "organization" {
  source          = "./modules/astro/platform/organization"
  organization_id = local.organization_id

  providers = {
    restapi = restapi.platform
  }
}

# Load the Cluster data source
module "cluster" {
  source     = "./modules/astro/platform/cluster"
  cluster_id = local.cluster_id

  organization_id = module.organization.id

  providers = {
    restapi = restapi.platform
  }
}

# Create the Workspaces
module "workspaces" {
  for_each     = { for workspace in local.workspaces : workspace.name => workspace }
  source       = "./modules/astro/platform/workspace"
  name         = each.value.name
  description  = each.value.description
  enforce_cicd = each.value.enforce_cicd

  organization_id = module.organization.id

  providers = {
    restapi = restapi.platform
  }
}

# Create the Workspace Teams and grant them the desired workspace permissions
module "organization_teams" {
  for_each        = { for team in local.organization_teams : team.name => team }
  source          = "./modules/astro/iam/team"
  name            = each.value.name
  organization_id = module.organization.id
  providers = {
    restapi = restapi.iam
  }
}

module "deployments" {
  for_each = { for deployment in flatten([
    for workspace in local.workspaces : [
      for deployment in workspace.deployments : {
        key                   = "${workspace.name}_${deployment.name}"
        workspace_name        = workspace.name
        name                  = deployment.name
        description           = deployment.description
        astro_runtime_version = deployment.astro_runtime_version
        executor              = deployment.executor
        contact_emails        = deployment.contact_emails
      }
    ]
  ]) : deployment.key => deployment }

  source                = "./modules/astro/platform/deployment"
  astro_runtime_version = each.value.astro_runtime_version
  cluster_id            = module.cluster.id
  executor              = each.value.executor
  is_ci_cd_enforced     = true
  is_dag_deploy_enabled = true
  name                  = each.value.name
  scheduler_au          = 5
  scheduler_count       = 1
  workspace_id          = module.workspaces[each.value.workspace_name].id
  contact_emails        = each.value.contact_emails
  description           = each.value.description

  environment_variables = [
    {
      key      = "MY_ENV_VAR"
      value    = "SECRET"
      isSecret = true
    }
  ]

  node_pool_id       = module.cluster.default_node_pool_id
  max_worker_count   = 10
  min_worker_count   = 0
  worker_concurrency = 16

  organization_id = module.organization.id

  providers = {
    restapi = restapi.platform
  }

  depends_on = [module.workspaces]
}

module "api_token" {
  for_each = { for api_token in flatten([
    for workspace_key, workspace in local.workspaces : [
      for deployment_key, deployment in workspace.deployments : {
        deployment_key     = "${workspace.name}_${deployment.name}"
        deployment_name    = deployment.name
        name               = deployment.api_token.name
        role               = deployment.api_token.role
        type               = deployment.api_token.type
        description        = deployment.api_token.description
        expiry_period_days = deployment.api_token.expiry_period_days
      }
    ]
  ]) : api_token.name => api_token }

  source             = "./modules/astro/iam/api_token"
  name               = each.value.name
  role               = each.value.role
  type               = each.value.type
  description        = each.value.description
  expiry_period_days = null # Does not expire

  entity_id       = module.deployments[each.value.deployment_key].id
  organization_id = module.organization.id

  providers = {
    restapi = restapi.iam
  }

  depends_on = [module.deployments]
}
