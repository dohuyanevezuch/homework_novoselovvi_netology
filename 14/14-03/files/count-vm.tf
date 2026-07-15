variable "count_vm" {
  description = "Сами значения в terraform.tfvars"
  type = object({
    resources = object({
      cores         = number
      memory        = number
      core_fraction = number
    })

    preemptible = bool

    disk = object({
      size = number
      type = string
    })

    net = object({
      nat = bool
    })
  })
}

#VM
resource "yandex_compute_instance" "vms_web" {
  depends_on = [ yandex_compute_instance.vms_db ]
  count = 2
  name = "web-${count.index+1}"
  zone = var.default_zone
  platform_id = var.default_platform

  resources {
    cores = var.count_vm.resources.cores
    memory = var.count_vm.resources.memory
    core_fraction = var.count_vm.resources.core_fraction
  }
  scheduling_policy {
    preemptible = var.count_vm.preemptible
  }
  boot_disk {
    initialize_params {
      image_id = local.default_os
      size = var.count_vm.disk.size
      type = var.count_vm.disk.type
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat = var.count_vm.net.nat
  }
  metadata = {
    ssh-keys = "${var.default_user}:${local.ssh_pub}"
  }
}