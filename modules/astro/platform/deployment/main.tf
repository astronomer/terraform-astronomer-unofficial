terraform {
  required_providers {
    restapi = {
      source  = "Mastercard/restapi"
      version = "1.18.2"
    }
  }
}

resource "restapi_object" "deployment" {
  path = "/organizations/${var.organization_id}/deployments"
  data = jsonencode(
    {
      "astroRuntimeVersion" : "${var.astro_runtime_version}",
      "clusterId" : "${var.cluster_id}",
      "executor" : "${var.executor}",
      "isCicdEnforced" : "${var.is_ci_cd_enforced}",
      "isDagDeployEnabled" : "${var.is_dag_deploy_enabled}",
      "name" : "${var.name}",
      "scheduler" : {
        "au" : "${var.scheduler_au}",
        "replicas" : "${var.scheduler_count}"
      },
      "type" : "HYBRID", # Other Types Not Implemented
      "workspaceId" : "${var.workspace_id}",
      "contactEmails" : "${var.contact_emails}",
      "description" : "${var.description}",
      "environmentVariables" : "${var.environment_variables}",
      # taskPodNodePoolId For KUBERNETES executor only. - Not Implemented
      "workerQueues" : [
        {
          "name" : "default"
          "isDefault" : true,
          "nodePoolId" : "${var.node_pool_id}",
          "maxWorkerCount" : "${var.max_worker_count}",
          "minWorkerCount" : "${var.min_worker_count}",
          "workerConcurrency" : "${var.worker_concurrency}",
        }
      ],
    }
  )
}

locals {
  api_response = jsondecode(resource.restapi_object.deployment.api_response)
}
