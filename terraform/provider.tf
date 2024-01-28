# Provider
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

#  backend "s3" {
#  endpoints = {
#    s3 = "https://storage.yandexcloud.net"
#  }
#  bucket     = "netology-diploma"
#  region     = "ru-central1"
#  key        = "netology-diploma/terraform.tfstate"
#  skip_region_validation      = true
#  skip_credentials_validation = true
#  skip_requesting_account_id  = true
#  }
}

provider "yandex" {
  zone = "ru-central1-b"
  service_account_key_file = "key.json"
  cloud_id  = "${var.yandex_cloud_id}"
  folder_id = "${var.yandex_folder_id}"
}
