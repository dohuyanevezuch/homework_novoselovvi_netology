#veriables
variable "default_disk" {
  type = object({
    name = string
    type = string
    size = number
  })
  default = {
    name = "vm_disk"
    type = "network-hdd"
    size = 1
  }
}

#disks
resource "yandex_compute_disk" "vms_disk" {
  count = 3
  name = "${var.default_disk.name}_${count.index+1}"
  type = var.default_disk.type
  size = var.default_disk.size

  labels = {
    environment = "${var.default_disk.name}_label-${count.index+1}"
  }

}

# vm storage (решил переиспользовать параметры count виртуальных машин, вместо создания доп переменной, для уменьшения кода)
resource "yandex_compute_instance" "storage" {
  name = "storage"
  zone = var.default_zone
  platform_id = var.default_platform
  resources {
    cores = var.count_vm.resources.cores
    memory = var.count_vm.resources.memory
    core_fraction = var.count_vm.resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = local.default_os
      size = var.count_vm.disk.size
      type = var.count_vm.disk.type
    }
  }
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.vms_disk

    content {
      disk_id = secondary_disk.value.id
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
