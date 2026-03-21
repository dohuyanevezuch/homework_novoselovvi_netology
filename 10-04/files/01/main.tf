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
  zone = "ru-central1-b"
}