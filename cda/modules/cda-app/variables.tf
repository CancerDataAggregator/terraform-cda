#
# General Vars
#
variable "dependencies" {
  # See: https://github.com/hashicorp/terraform/issues/21418#issuecomment-495818852
  type        = any
  default     = []
  description = "Work-around for Terraform 0.12's lack of support for 'depends_on' in custom modules."
}

variable "enable" {
  type        = bool
  description = "Enable flag for this module. If set to false, no resources will be created."
  default     = true
}

variable "google_project" {
  type        = string
  description = "The google project"
}

variable "owner" {
  type        = string
  description = " or developer"
  default     = "cda"
}

variable "master_region" {
  type        = string
  description = "GCP region being used"
  default     = null
}

locals {
  owner             = var.owner == "" ? terraform.workspace : var.owner
  service           = "cda"
  container_name    = "cda"
  master_name       = "cda-master-${var.master_region}"
  error_metric_name = "cda-prod-errors"
}

## new
variable dns_zone {
  type        = string
  default     = ""
  description = "The name of managed dns zone to put cname and a record in"
}

variable dns_name {
  type        = string
  description = "List of DNS names to generate global IP addresses, A-records, and CNAME-records for."
  default     = ""
}

variable "environment" {
  description = "environment being deployed"
  default     = ""
  type        = string
}

variable "ip_only" {
  type        = bool
  description = "Enable flag for this module. If set to false, no resources will be created."
  default     = false
}

variable "namespace" {
  type        = string
  description = "kubernetes namespace"
}

variable "gsa_name" {
  type        = string
  description = "google service account for workloadid binding"
}

variable "ksa_name" {
  type        = string
  description = "kubernetes service account for workloadid binding"
}

variable "roles" {
  type        = list(string)
  description = "List of google roles to apply to service account"
}
