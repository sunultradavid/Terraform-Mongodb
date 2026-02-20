variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "mongodbatlas_org_id" {
  description = "MongoDB Atlas organization ID"
  type        = string
}

variable "cluster_instance_size" {
  description = "Cluster instance size"
  type        = string
  default     = "M10"
}

variable "mongodb_version" {
  description = "MongoDB version"
  type        = string
  default     = "6.0"
}

variable "mongodb_password" {
  description = "MongoDB user password"
  type        = string
  sensitive   = true
}
