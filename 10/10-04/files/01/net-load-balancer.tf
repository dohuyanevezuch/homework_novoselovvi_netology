# Балансировщик
resource "yandex_lb_network_load_balancer" "balancer-task1" {
    name = "balancer-task1"
    deletion_protection = "false"
    listener {
        name = "listener-task1"
        port = 80
        external_address_spec {
            ip_version = "ipv4"
        }
    }
    attached_target_group {
        target_group_id = yandex_lb_target_group.target-group-task1.id

        healthcheck {
            name = "http"
            http_options {
                port = 80
                path = "/"
            }
        }
    }
}