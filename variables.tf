# General variables
variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "fullstack-app"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# Networking variables
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# Application variables
variable "backend_port" {
  description = "Port for backend server"
  type        = number
  default     = 3001
}

variable "frontend_port" {
  description = "Port for frontend server"
  type        = number
  default     = 3000
}

# MongoDB Atlas variables
variable "mongodbatlas_public_key" {
  description = "MongoDB Atlas public key"
  type        = string
  sensitive   = true
}

variable "mongodbatlas_private_key" {
  description = "MongoDB Atlas private key"
  type        = string
  sensitive   = true
}

variable "mongodbatlas_org_id" {
  description = "MongoDB Atlas organization ID"
  type        = string
}

variable "mongodbatlas_instance_size" {
  description = "MongoDB Atlas cluster instance size"
  type        = string
  default     = "M10"
}

variable "mongodb_version" {
  description = "MongoDB version"
  type        = string
  default     = "6.0"
}

variable "mongodb_password" {
  description = "MongoDB database user password"
  type        = string
  sensitive   = true
}

# GitHub variables
variable "github_repository" {
  description = "GitHub repository name (owner/repo)"
  type        = string
}

variable "github_branch" {
  description = "GitHub branch to deploy from"
  type        = string
  default     = "main"
}

# S3 variables
variable "assets_bucket_name" {
  description = "Name of S3 bucket for assets"
  type        = string
}

variable "cloudfront_price_class" {
  description = "CloudFront price class"
  type        = string
  default     = "PriceClass_100"
}
