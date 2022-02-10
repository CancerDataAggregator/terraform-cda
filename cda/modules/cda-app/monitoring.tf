resource "google_monitoring_notification_channel" "cda_errors" {
  display_name = "CDA Errors Slack"
  type         = "slack"
  project      = var.google_project
  labels = {
    "channel_name" = "#cda-errors-prod"
  }
}

resource "google_logging_metric" "cda_errors_metric" {
  name    = local.error_metric_name
  filter  = "resource.type=\"k8s_container\" AND resource.labels.namespace_name=\"${var.namespace}\" AND resource.labels.location=\"${var.master_region}\" AND resource.labels.cluster_name=\"${local.master_name}\" AND resource.labels.project_id=\"${var.google_project}\" AND resource.labels.container_name=\"${local.container_name}\" AND severity>=ERROR"
  project = var.google_project
  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "cda_alert_policy" {
  display_name          = "CDA Production Errors"
  combiner              = "OR"
  enabled               = true
  notification_channels = google_monitoring_notification_channel.cda_errors.*.name
  depends_on            = [google_monitoring_notification_channel.cda_errors, google_logging_metric.cda_errors_metric]
  conditions {
    display_name = "CDA Prod Errors"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/${local.error_metric_name}"
      comparison      = "COMPARISON_GT"
      duration        = "0s"
      threshold_value = 1
      aggregations {
        alignment_period = "300s"
        cross_series_reducer = "REDUCE_NONE"
        per_series_aligner = "ALIGN_COUNT"
      }
      trigger {
        count = 1
      }
    }
  }
}
