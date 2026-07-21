resource "yandex_compute_instance" "vms" {
  for_each = var.instances

  name               = each.value.name
  hostname           = coalesce(each.value.hostname, each.value.name)
  service_account_id = var.service_account_id

  zone        = each.value.zone
  platform_id = var.platform_id

  allow_stopping_for_update = true

  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      type     = each.value.disk_type
      size     = each.value.disk_size
    }
  }

  network_interface {
    subnet_id = each.value.subnet_id
    nat       = each.value.nat

    security_group_ids = var.security_group_ids
  }

  metadata_options {
    gce_http_endpoint = 1
    gce_http_token    = 1
  }

  metadata = merge(
    {
      ssh-keys = "${var.ssh_username}:${var.ssh_public_key}"
    },
    var.user_data != null ? {
      user-data = var.user_data
    } : {}
  )

  labels = each.value.labels
}