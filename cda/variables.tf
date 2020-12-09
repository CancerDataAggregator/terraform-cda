## core-infrastructure vars
variable "google_project" {
  type        = string
  description = "The google project being deployed to"
  default     = ""
}

variable "node_regions" {
  type = map(object({ region = string }))
  default = {
    cda-node-us-central-1 = {
      region = "us-central1"
    }
  }
}

variable "k8_network_name" {
  description = "core network name to be deployed and put k8 cluster on"
  default     = ""
}

variable "k8_subnet_name" {
  description = "name of gcp the subnet"
  default     = ""
}

variable "node_count" {
  type        = number
  description = "number of kubernetes nodes depends on if region is us-central1 1 will deploy 3 and us-central1-a 3 will deploy 3"
  default     = "1"
}

variable "machine_type" {
  type        = string
  description = "type of machine used for kubernetes"
  default     = "n1-standard-2"
}

variable "region" {
  description = "GCP region being used"
  default     = "us-central1"
}

variable "version_prefix" {
  type        = string
  default     = "1.17.13-gke.1400"
  description = "version of gke to be deployed"
}

variable "enable_flow_logs" {
  type        = bool
  default     = false
  description = "flag for enabling flowlog"
}

## cda-app vars

variable "dns_name" {
  type        = string
  description = "List of DNS names to generate global IP addresses, A-records, and CNAME-records for."
  default     = ""
}

variable "environment" {
  type        = string
  description = "environment being deployed"
  default     = ""
}

variable "dns_zone" {
  type        = string
  description = "global DNS zone to be deployed"
  default     = ""
}

locals {
  workloadid_names = [var.environment]
}

variable "ip_only" {
  type        = bool
  description = "Enable flag for only create a global static ip vs ip and dns"
  default     = false
}
