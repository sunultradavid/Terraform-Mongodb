output "backend_api_endpoint" {
  description = "Backend API endpoint URL"
  value       = module.backend.api_endpoint
}

output "frontend_url" {
  description = "Frontend application URL"
  value       = module.frontend.frontend_url
}

output "mongodb_connection_string" {
  description = "MongoDB connection string (sensitive)"
  value       = module.mongodb_atlas.connection_string
  sensitive   = true
}

output "s3_bucket_name" {
  description = "S3 bucket name for assets"
  value       = module.backend.s3_bucket_name
}

output "github_actions_roles" {
  description = "IAM roles for GitHub Actions"
  value = {
    backend_role_arn  = module.backend.github_actions_role_arn
    frontend_role_arn = module.frontend.github_actions_role_arn
  }
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = module.frontend.cloudfront_distribution_id
}
