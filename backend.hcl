endpoints = {
  s3       = "https://storage.yandexcloud.net"
  dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gnvvcq6rkmbooec0p2/etnarvaa3gch35i2elp7"
}

bucket         = "novoselovvi-terraform-state"
key            = "finish-homework/terraform.tfstate"
region         = "ru-central1"
dynamodb_table = "state-lock-table"

skip_region_validation      = true
skip_credentials_validation = true
skip_requesting_account_id  = true
skip_s3_checksum            = true