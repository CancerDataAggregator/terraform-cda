module "enable-services" {
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/api-services?ref=services-0.3.0-tf-0.12"

  providers = {
    google.target = google-beta
  }
  project = var.google_project
  services = [
    "iamcredentials.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
    "genomics.googleapis.com",
    "compute.googleapis.com",
    "sqladmin.googleapis.com",
    "dns.googleapis.com",
    "sql-component.googleapis.com",
    "monitoring.googleapis.com",
    "sqladmin.googleapis.com",
    "container.googleapis.com",
    "storage-api.googleapis.com",
    "storage-component.googleapis.com",
    "servicenetworking.googleapis.com",
    "stackdriver.googleapis.com",
    "logging.googleapis.com"
  ]
}

# gcp networking, k8 cluster
module "core-infrastructure" {
  source = "./modules//core-infrastructure"

  dependencies = [module.enable-services]

  master_region    = var.region
  node_regions     = var.node_regions
  google_project   = var.google_project
  k8_network_name  = var.k8_network_name
  k8_subnet_name   = var.k8_subnet_name
  node_count       = var.node_count
  machine_type     = var.machine_type
  version_prefix   = var.version_prefix
  dns_zone_name    = var.dns_zone
  enable_flow_logs = var.enable_flow_logs

  providers = {
    google.target      = google
    google-beta.target = google-beta
  }
}

# dns ips
module "cda-app" {
  source = "./modules//cda-app"

  dependencies = [module.core-infrastructure]

  google_project = var.google_project
  dns_name       = var.dns_name
  environment    = var.environment
  ip_only        = var.ip_only
  dns_zone       = var.dns_zone
  namespace      = var.namespace
  gsa_name       = var.gsa_name
  ksa_name       = var.ksa_name
  roles          = var.roles

  providers = {
    google.target       = google
    google-beta.target  = google-beta
    google-beta.cda-dns = google-beta
    vault.target        = vault.broad
  }
}
