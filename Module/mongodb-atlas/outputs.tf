output "connection_string" {
  value = mongodbatlas_cluster.main.connection_strings[0].standard_srv
  sensitive = true
}

output "cluster_id" {
  value = mongodbatlas_cluster.main.id
}

output "project_id" {
  value = mongodbatlas_project.main.id
}
