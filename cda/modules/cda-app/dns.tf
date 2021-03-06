# Global Ip, CNAME, A Record
data google_dns_managed_zone dns_zone {
  count    = var.ip_only ? 0 : 1
  provider = google-beta.cda-dns
  name     = var.dns_zone
}


resource google_compute_global_address global_ip_address {
  provider   = google.target
  name       = "cda-${var.environment}-ip"
  depends_on = [var.dependencies]
}

resource google_dns_record_set a_dns {
  count    = var.ip_only ? 0 : 1
  provider = google-beta.cda-dns
  type     = "A"
  ttl      = "300"

  managed_zone = data.google_dns_managed_zone.dns_zone[0].name
  name         = "${var.dns_name}-global.${data.google_dns_managed_zone.dns_zone[0].dns_name}"
  rrdatas      = [google_compute_global_address.global_ip_address.address]
  depends_on   = [var.dependencies, data.google_dns_managed_zone.dns_zone]
}

resource google_dns_record_set cname_dns {
  count    = var.ip_only ? 0 : 1
  provider = google-beta.cda-dns
  type     = "CNAME"
  ttl      = "300"

  managed_zone = data.google_dns_managed_zone.dns_zone[0].name
  name         = "${var.dns_name}.${data.google_dns_managed_zone.dns_zone[0].dns_name}"
  rrdatas      = [google_dns_record_set.a_dns[0].name]
  depends_on   = [var.dependencies, data.google_dns_managed_zone.dns_zone]
}
