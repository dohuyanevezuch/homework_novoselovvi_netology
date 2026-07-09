terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.213.0"
    }

    docker = {
      source = "kreuzwerker/docker"
      version = "4.5.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6"
    }
  }
}

provider yandex {
    zone = var.yc-zone
}

provider docker {
  host = "ssh://ubuntu@${yandex_compute_instance.vm-task2.network_interface[0].nat_ip_address}:22"
  ssh_opts = ["-i", "~/.ssh/id_ed25519_YC"]
}