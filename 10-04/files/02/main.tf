terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.193.0"
    }
  }
  required_version = ">= 0.13"
}

provider yandex {
  zone = var.location_zone
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
}