# https://docs.astronomer.io/astro/api/platform-api-reference#tag/Cluster/operation/GetCluster

output "id" {
  value       = tostring(data.restapi_object.cluster.api_data.id)
  description = "The ID of the Cluster."
}

output "vpc_subnet_range" {
  value       = tostring(data.restapi_object.cluster.api_data.vpcSubnetRange)
  description = "The CIDR range of the Cluster's VPC."
}

output "region" {
  value       = tostring(data.restapi_object.cluster.api_data.region)
  description = "The Region of the Cluster."
}

output "default_node_pool_id" {
  value       = tostring([for pool in local.api_response.nodePools : pool.id if pool.isDefault == true][0])
  description = "The ID of the Default Node Pool."
}
