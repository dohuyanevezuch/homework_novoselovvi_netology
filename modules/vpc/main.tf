resource "yandex_vpc_network" "net" {
  name   = var.vpc_name
  labels = var.labels
}

resource "yandex_vpc_subnet" "subnet" {
  for_each = var.subnets

  name           = each.value.name
  description    = each.value.description
  zone           = each.value.zone
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = each.value.cidr_blocks

  labels = var.labels
}

resource "yandex_vpc_security_group" "sg" {
  name        = var.security_group_name
  description = "Разрешает Порты"
  network_id  = yandex_vpc_network.net.id

  labels = var.labels

  dynamic "ingress" {
    for_each = toset(var.allow_ports)

    content {
      description    = "Allow TCP port ${ingress.value}"
      protocol       = "TCP"
      port           = ingress.value
      v4_cidr_blocks = var.allowed_cidrs
    }
  }

  egress {
    description    = "Allow all outgoing traffic"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "mysql_sg" {
  name        = "${var.vpc_name}-mysql-sg"
  description = "Allow MySQL from internal subnets"
  network_id  = yandex_vpc_network.net.id

  ingress {
    description = "MySQL access from VPC"
    protocol    = "TCP"
    port        = 3306

    v4_cidr_blocks = flatten([
      for subnet in var.subnets :
      subnet.cidr_blocks
    ])
  }

  egress {
    description    = "Allow all outgoing traffic"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  labels = var.labels
}