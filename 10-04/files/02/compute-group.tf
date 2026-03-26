resource "yandex_compute_instance_group" "vm-group" {
  name                = "vm-group"
  folder_id           = var.folder_id
  service_account_id  = data.yandex_iam_service_account.admin.id
  deletion_protection = false
  instance_template {
    platform_id = "standard-v3"
    resources {
        cores  = 2
        memory = 1
        core_fraction = 20
    }
    scheduling_policy {
        preemptible = true
    }

    boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
            type = "network-hdd"
            size = 10
        }
    }  

    network_interface {
        network_id = "${yandex_vpc_network.network-task2.id}"
        subnet_ids = ["${yandex_vpc_subnet.subnet-task2.id}"]
        nat = true
    }

    metadata = {
        ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
        user-data = file("cloud-init.yaml")
    }
  }

  scale_policy {
    fixed_scale {
      size = 2
    }
  }

  allocation_policy {
    zones = [var.location_zone]
  }

  deploy_policy {
    max_unavailable = 2
    max_expansion   = 0
  }

  load_balancer {
    target_group_name = "target-group"
  }
}