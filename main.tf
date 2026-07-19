/*resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
} */

module "vpc" {
  source = "./vpc"
  env_name = var.vpc_name
  zone = var.default_zone
  v4_cidr_blocks = var.default_cidr
}

data "template_file" "cloudinit" {
  template = file("${path.module}/cloud-init.yml")

  vars = {
    ssh_public_keys = jsonencode([
      var.vms_ssh_root_key
    ])
  }
}

module "marketing_vm" {
  source = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"

  env_name      = "marketing"
  network_id    = module.vpc.network_id
  subnet_zones  = [module.vpc.subnet.zone]
  subnet_ids    = [module.vpc.subnet_id]
  instance_name = "marketing-vm"
  instance_count = 1

  image_family = "ubuntu-2004-lts"
  public_ip    = true

  labels = {
    project = "marketing"
    owner   = "novoselovvi"
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = "1"
  }
}

module "analytics_vm" {
  source = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"

  env_name      = "analytics"
  network_id    = module.vpc.network_id
  subnet_zones  = [module.vpc.subnet.zone]
  subnet_ids    = [module.vpc.subnet_id]
  instance_name = "analytics-vm"
  instance_count = 1

  image_family = "ubuntu-2004-lts"
  public_ip    = true

  labels = {
    project = "analytics"
    owner   = "novoselovvi"
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = "1"
  }
}