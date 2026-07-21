subnets = {
  "subnet_a" = {
    name        = "subnet-a"
    description = "ru-central1-a"
    zone        = "ru-central1-a"
    cidr_blocks = ["10.0.1.0/24"]
  }
  "subnet_b" = {
    name        = "subnet-b"
    description = "ru-central1-b"
    zone        = "ru-central1-b"
    cidr_blocks = ["10.0.2.0/24"]
  }
}

vms = {
  "vm_1" = {
    name          = "terraform-vm-1"
    subnet_key    = "subnet_a"
    cores         = 2
    memory        = 2
    core_fraction = 20
    disk_size     = 15
    nat           = true
    labels = {
      project = "terraform-final-task"
      role    = "web"
    }
  }
  "vm_2" = {
    name          = "terraform-vm-2"
    subnet_key    = "subnet_b"
    cores         = 2
    memory        = 2
    core_fraction = 20
    disk_size     = 15
    nat           = true
    labels = {
      project = "terraform-final-task"
      role    = "web"
    }
  }
}

registry_name = "terraform-final-registry"

db_cluster_name = "terraform-mysql"
db_name         = "application_db"
db_user         = "application_user"

vms_ssh_private_key = "~/.ssh/key_yc_terraform"