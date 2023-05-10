output "state_bucket_name" {
  description = "S3 State Bucket Name"
  value       = module.backend.state_bucket_name
}

output "dynamodb_table_name" {
  description = "DynamoDB Table Name"
  value       = module.backend.dynamodb_table_name
}

output "log_bucket_name" {
  description = "S3 Logging Bucket Name"
  value       = module.backend.log_bucket_name
}
