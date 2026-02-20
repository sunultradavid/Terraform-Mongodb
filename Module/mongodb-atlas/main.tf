# Create MongoDB Atlas project
resource "mongodbatlas_project" "main" {
  name   = "${var.project_name}-${var.environment}"
  org_id = var.mongodbatlas_org_id
}

# Create IP access list
resource "mongodbatlas_project_ip_access_list" "main" {
  project_id = mongodbatlas_project.main.id
  cidr_block = "0.0.0.0/0"  # Restrict this in production
  comment    = "Allow access from anywhere (restrict in production)"
}

# Create database user
resource "mongodbatlas_database_user" "main" {
  username           = "${var.project_name}-${var.environment}-user"
  password           = var.mongodb_password
  project_id         = mongodbatlas_project.main.id
  auth_database_name = "admin"

  roles {
    role_name     = "readWrite"
    database_name = "${var.project_name}-${var.environment}"
  }
}

# Create Atlas cluster
resource "mongodbatlas_cluster" "main" {
  project_id   = mongodbatlas_project.main.id
  name         = "${var.project_name}-${var.environment}-cluster"
  cluster_type = "REPLICASET"

  replication_specs {
    num_shards = 1

    regions_config {
      region_name     = "US_EAST_1"
      electable_nodes = 3
      priority        = 7
      read_only_nodes = 0
    }
  }

  # Provider settings
  provider_name               = "AWS"
  provider_instance_size_name = var.cluster_instance_size
  provider_region_name        = "US_EAST_1"
  mongo_db_major_version      = var.mongodb_version

  # Advanced configuration
  advanced_configuration {
    javascript_enabled                   = true
    minimum_enabled_tls_protocol         = "TLS1_2"
    no_table_scan                        = false
    oplog_size_mb                        = null
    sample_refresh_interval_seconds      = null
    transaction_lifetime_limit_seconds   = null
  }

  # Backup settings
  backup_enabled               = var.environment == "prod" ? true : false
  pit_enabled                  = var.environment == "prod" ? true : false
}
