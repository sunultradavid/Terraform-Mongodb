output "api_endpoint" {
  value = "https://api.${var.project_name}.com"  # Update with actual domain
}

output "ecr_repository_url" {
  value = aws_ecr_repository.backend.repository_url
}

output "s3_bucket_name" {
  value = aws_s3_bucket.assets.id
}

output "github_actions_role_arn" {
  value = aws_iam_role.github_actions_backend.arn
}

output "secrets_arn" {
  value = aws_secretsmanager_secret.backend_env.arn
}
