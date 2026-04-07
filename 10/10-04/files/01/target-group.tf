# Таргет группа
resource "yandex_lb_target_group" "target-group-task1" {
    name = "target-group-task1"
    dynamic "target" {
        for_each = yandex_compute_instance.vm
        content {
            subnet_id = yandex_vpc_subnet.subnet-task1.id
            address = target.value.network_interface.0.ip_address
        }
    }
}