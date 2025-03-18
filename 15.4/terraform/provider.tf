locals {
    sa_key_file = file("~/.yc-bender-key.json")
}

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = var.yc_zone_a
  service_account_key_file = local.sa_key_file
}