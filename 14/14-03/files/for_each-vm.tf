variable "each_vm" {
  type = list(object({
    vm_name = string
    cpu = number
    ram = number
    cpu_frac = number
    preemptible = bool
    disk_volume = number
    disk_type = string
    nat = bool
  }))
  description = "Сами значения в terraform.tfvars"
  
  default = [ {
    vm_name = "netology_vm"
    cpu = 2
    ram = 2
    cpu_frac = 50
    preemptible = true
    disk_volume = 15
    disk_type = "network-hdd"
    nat = true
  } ]
}

#VM
resource "yandex_compute_instance" "vms_db" {
  for_each = { for vm in var.each_vm : vm.vm_name => vm }
  name = each.value.vm_name
  zone = var.default_zone
  platform_id = var.default_platform
  resources {
    cores = each.value.cpu
    memory = each.value.ram
    core_fraction = each.value.cpu_frac
  }
  scheduling_policy {
    preemptible = each.value.preemptible
  }
  boot_disk {
    initialize_params {
      image_id = local.default_os
      size = each.value.disk_volume
      type = each.value.disk_type
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat = each.value.nat
  }
  metadata = {
    ssh-keys = "${var.default_user}:${local.ssh_pub}"
  }
}