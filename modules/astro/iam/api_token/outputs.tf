output "id" {
  value       = tostring(local.api_decoded_response.id)
  description = "The API token ID"
}

output "astronomer_api_token" {
  value       = tostring(local.api_decoded_response.token)
  description = "The API token."
  sensitive   = true
}

output "type" {
  value       = tostring(local.api_decoded_response.type)
  description = "The scope of the API token."
}
