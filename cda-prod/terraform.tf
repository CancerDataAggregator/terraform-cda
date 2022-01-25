/*
* Configuration of the Terraform Backend Storage
*/
terraform {
  backend "gcs" {
    path        = "cda/tf-statefile"
    credentials = "env_svc.json"
  }
}

provider "google" {
  credentials = file("env_svc.json")
  project     = var.google_project
  region      = var.region
  version     = "~> 3.55.0"
}

provider "google-beta" {
  credentials = file("env_svc.json")
  project     = var.google_project
  region      = var.region
  version     = "~> 3.55.0"
}

provider "vault" {
  alias   = "broad"
  address = "https://clotho.broadinstitute.org:8200"
  version = "~> 3.2.1"
}
