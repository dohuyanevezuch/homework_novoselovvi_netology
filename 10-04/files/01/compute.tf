# Образ ОС
data "yandex_compute_image" "ubuntu_2204_lts" {
    family = "ubuntu-2204-lts"
}

# ВМ
resource "yandex_compute_instance" "vm" {
    count = 2

    name        = "homework-10-04-vm-${count.index}"
    hostname = "homework-10-04-vm-${count.index}"
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
        subnet_id = yandex_vpc_subnet.subnet-task1.id
        nat = true
    }   
    metadata = {
        ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
        user-data = file("cloud-init.yaml")
    }
}

# Сеть
resource "yandex_vpc_network" "network-task1" {
    name = "network-task1"  
}
resource "yandex_vpc_subnet" "subnet-task1" {
    name = "subnet-task1"
    network_id = yandex_vpc_network.network-task1.id
    v4_cidr_blocks = ["172.24.8.0/24"]
}
