output "instance_ids" {
  description = "ID виртуальных машин"

  value = {
    for key, instance in yandex_compute_instance.vms :
    key => instance.id
  }
}

output "internal_ip_addresses" {
  description = "Внутренние IP-адреса"

  value = {
    for key, instance in yandex_compute_instance.vms :
    key => instance.network_interface[0].ip_address
  }
}

output "external_ip_addresses" {
  description = "Публичные IP-адреса"

  value = {
    for key, instance in yandex_compute_instance.vms :
    key => try(instance.network_interface[0].nat_ip_address, null)
  }
}

output "fqdn" {
  description = "FQDN виртуальных машин"

  value = {
    for key, instance in yandex_compute_instance.vms :
    key => instance.fqdn
  }
}