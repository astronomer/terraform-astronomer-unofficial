output "id" {
  value       = tostring(data.restapi_object.team.api_data.id)
  description = "The team ID."
}

output "name" {
  value       = tostring(data.restapi_object.team.api_data.name)
  description = "The team name."
}

output "roles" {
  description = "The Team's Workspace roles."
  value       = can(data.restapi_object.team.api_data.roles) ? data.restapi_object.team.api_data.roles : []
}
