provider "google" {
  alias = "target"
}

provider "google-beta" {
  alias = "target"
}

provider google-beta {
  alias = "cda-dns"
}
