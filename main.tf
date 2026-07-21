data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2404-lts"
}

# VPC
module "vpc" {
  source = "./modules/vpc"

  vpc_name            = var.vpc_name
  security_group_name = "terraform-final-sg"
  allow_ports         = [22, 80, 443]

  subnets = var.subnets

  labels = {
    project = "terraform-final-task"
  }
}

resource "yandex_iam_service_account" "application_vm" {
  name        = "application-vm"
  description = "Сервисный Аккаунт для ВМ"
  folder_id   = var.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "registry_puller" {
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.application_vm.id}"

  sleep_after = 15
}

module "vm" {
  source = "./modules/vm"

  image_id = data.yandex_compute_image.ubuntu.id

  ssh_username       = var.ssh_username
  ssh_public_key     = var.vms_ssh_root_key
  service_account_id = yandex_iam_service_account.application_vm.id
  user_data = templatefile("${path.module}/cloud-init.yaml.tftpl", {
    application_image = "${module.registry.registry_url}/application:1.0"
    mysql_endpoint    = "${module.mysql.hosts[0]}:3306"
    mysql_user        = module.mysql.user_name
    mysql_password    = var.db_password
    mysql_database    = module.mysql.database_name
  })

  security_group_ids = [
    module.vpc.security_group_id
  ]
  instances = {
    for vm_key, vm in var.vms : vm_key => {
      name      = vm.name
      hostname  = coalesce(vm.hostname, vm.name)
      zone      = var.subnets[vm.subnet_key].zone
      subnet_id = module.vpc.subnet_ids[vm.subnet_key]

      cores         = vm.cores
      memory        = vm.memory
      core_fraction = vm.core_fraction
      disk_size     = vm.disk_size
      disk_type     = vm.disk_type
      nat           = vm.nat
      labels        = vm.labels
    }
  }
}

# РЕГИСТРИ
module "registry" {
  source = "./modules/registry"

  reg_name        = var.registry_name
  folder_id       = var.folder_id
  repository_name = "application"

  labels = {
    project = "terraform-final-task"
  }
}

# MYSQL
module "mysql" {
  source = "./modules/mysql"

  cluster_name = var.db_cluster_name

  network_id = module.vpc.network_id
  subnet_id  = module.vpc.subnet_ids["subnet_b"]
  zone       = "ru-central1-b"

  security_group_ids = [
    module.vpc.mysql_security_group_id
  ]

  database_name = var.db_name
  user_name     = var.db_user
  user_password = var.db_password

  environment         = "PRESTABLE"
  mysql_version       = "8.0"
  assign_public_ip    = false
  deletion_protection = false

  labels = {
    project = "terraform-final-task"
  }
}