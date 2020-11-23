# workload identity GSA to KSA binding, this is a 1:1 so 1 GSA to KSA
module workloadid {
  source = "github.com/broadinstitute/terraform-cda.git//modules/workloadidentity?ref=cda-modules-0.0.1"
  providers = {
    google.target      = google.target
    google-beta.target = google-beta.target
  }

  google_project   = var.google_project
  dependencies     = var.dependencies
  workloadid_names = var.workloadid_names
}
