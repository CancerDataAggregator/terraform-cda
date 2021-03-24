resource google_logging_project_sink query_sink {
  name = "cda-query-sink-${var.environment}"

  # Can export to pubsub, cloud storage, or bigquery
  destination = "storage.googleapis.com/broad-cda-${var.environment}"

  filter = "resource.labels.project_id=\"${var.google_project}\" AND resource.labels.namespace_name=\"${var.environment}\" AND jsonPayload.message=~\"^QUERY:\""

  # Use a unique writer (creates a unique service account used for writing)
  unique_writer_identity = true
}
