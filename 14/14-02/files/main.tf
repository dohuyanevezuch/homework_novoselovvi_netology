resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop_a" {
  name           = "${var.vpc_name}-a"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
  route_table_id = yandex_vpc_route_table.route_table.id
}
resource "yandex_vpc_subnet" "develop_b" {
  name           = "${var.vpc_name}-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.2.0/24"]
  route_table_id = yandex_vpc_route_table.route_table.id
}

#NAT GETAWAY
resource "yandex_vpc_gateway" "nat" {
  name = "nat"
  shared_egress_gateway {}
}
resource "yandex_vpc_route_table" "route_table" {
  name = "route_table"
  network_id = yandex_vpc_network.develop.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id = yandex_vpc_gateway.nat.id
  }
}


data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}
resource "yandex_compute_instance" "platform" {
  name        = local.netology_vm_web_name
  platform_id = var.vm_platform
  resources {
    cores         = var.vms_resoucres.web.cores
    memory        = var.vms_resoucres.web.memory
    core_fraction = var.vms_resoucres.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_a.id
    nat       = false
  }

  metadata = var.metadata

}

resource "yandex_compute_instance" "db" {
  name        = local.netology_vm_db_name
  platform_id = var.vm_platform
  zone = "ru-central1-b"
  resources {
    cores         = var.vms_resoucres.db.cores
    memory        = var.vms_resoucres.db.memory
    core_fraction = var.vms_resoucres.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_b.id
    nat       = false
  }

  metadata = var.metadata

}
