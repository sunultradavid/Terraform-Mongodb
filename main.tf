# Configure providers
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  # Backend configuration for storing state (update with your bucket)
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "fullstack-app/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}

# Configure AWS provider
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  }
}

# Configure MongoDB Atlas provider
provider "mongodbatlas" {
  public_key  = var.mongodbatlas_public_key
  private_key = var.mongodbatlas_private_key
}

# Data sources
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# Random suffix for unique resource names
resource "random_id" "suffix" {
  byte_length = 4
}

# Networking Module
module "networking" {
  source = "./modules/networking"

  environment     = var.environment
  project_name    = var.project_name
  vpc_cidr        = var.vpc_cidr
  availability_zones = var.availability_zones
}

# MongoDB Atlas Module
module "mongodb_atlas" {
  source = "./modules/mongodb-atlas"

  environment           = var.environment
  project_name          = var.project_name
  mongodbatlas_org_id   = var.mongodbatlas_org_id
  cluster_instance_size = var.mongodbatlas_instance_size
  mongodb_version       = var.mongodb_version
}

# Backend Module (Node.js/Express)
module "backend" {
  source = "./modules/backend"

  environment        = var.environment
  project_name       = var.project_name
  vpc_id             = module.networking.vpc_id
  public_subnet_ids  = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids
  backend_port       = var.backend_port
  mongodb_uri        = module.mongodb_atlas.connection_string
  mongodb_password   = var.mongodb_password
  
  # GitHub Actions related
  github_repository  = var.github_repository
  github_branch      = var.github_branch
  
  # S3 bucket for uploads
  s3_bucket_name     = var.assets_bucket_name
  
  depends_on = [module.networking, module.mongodb_atlas]
}

# Frontend Module (Next.js)
module "frontend" {
  source = "./modules/frontend"

  environment          = var.environment
  project_name         = var.project_name
  vpc_id               = module.networking.vpc_id
  public_subnet_ids    = module.networking.public_subnet_ids
  frontend_port        = var.frontend_port
  backend_api_url      = module.backend.api_endpoint
  github_repository    = var.github_repository
  github_branch        = var.github_branch
  cloudfront_price_class = var.cloudfront_price_class
  
  depends_on = [module.backend]
}
