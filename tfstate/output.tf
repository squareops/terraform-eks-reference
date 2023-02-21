output "state_bucket_name" {
  description = "bucket name with id"
  value       = module.backend.state_bucket_name
}

output "dynamodb_table_name" {
  description = "dynamodb table name"
  value       = module.backend.dynamodb_table_name
}

output "log_bucket_name" {
  description = "logging table name"
  value       = module.backend.log_bucket_name
}
