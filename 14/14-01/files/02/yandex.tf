variable "yc-zone" {
  type = string
  default = "ru-central1-b"
}

resource "yandex_compute_instance" "vm-task2"{
    name = "novoselovi-terraform"
    zone = var.yc-zone
    platform_id = "standard-v3"
    scheduling_policy {
        preemptible = true
    }
    resources {
        cores = 2
        memory = 2
    }

    boot_disk {
        disk_id = yandex_compute_disk.disk1.id
    }

    network_interface {
        subnet_id = data.yandex_vpc_subnet.default.id
        nat = true
    }

    metadata = {
        ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519_YC.pub")}"
    }
}

resource "yandex_compute_disk" "disk1" {
    image_id = "fd83esfomhq25p2ono90"
    zone = var.yc-zone
    type = "network-hdd"
    size = 20
}

data "yandex_vpc_network" "default" {
  name = "default"
}

data "yandex_vpc_subnet" "default" {
  name = "default-ru-central1-b"
}