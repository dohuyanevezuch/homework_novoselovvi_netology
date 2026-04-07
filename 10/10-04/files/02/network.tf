resource "yandex_vpc_network" "network-task2" {
  name = "network-task2"
}

resource "yandex_vpc_subnet" "subnet-task2" {
  name           = "subnet-task2"
  zone           = var.location_zone
  network_id     = "${yandex_vpc_network.network-task2.id}"
  v4_cidr_blocks = ["172.24.8.0/24"]
}

resource "yandex_lb_network_load_balancer" "lb-task2" {
  name = "network-load-balancer-1"

  listener {
    name = "network-load-balancer-1-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.vm-group.load_balancer.0.target_group_id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}