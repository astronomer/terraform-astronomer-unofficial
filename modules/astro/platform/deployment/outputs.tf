output "id" {
  value       = tostring(resource.restapi_object.deployment.api_data.id)
  description = "The ID of the Deployment."
}

output "workload_identity" {
  value       = tostring(resource.restapi_object.deployment.api_data.workloadIdentity)
  description = "The Deployment's workload identity. IAM Role associated with this Deployment."
}
