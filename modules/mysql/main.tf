resource "yandex_mdb_mysql_cluster" "sql_cluster" {
  name        = var.cluster_name
  environment = var.environment
  network_id  = var.network_id
  version     = var.mysql_version

  security_group_ids = var.security_group_ids

  resources {
    resource_preset_id = var.resource_preset_id
    disk_type_id       = var.disk_type_id
    disk_size          = var.disk_size
  }

  host {
    zone             = var.zone
    subnet_id        = var.subnet_id
    assign_public_ip = var.assign_public_ip
  }

  backup_window_start {
    hours   = 2
    minutes = 0
  }

  backup_retain_period_days = var.backup_retain_period_days
  deletion_protection       = var.deletion_protection

  maintenance_window {
    type = "ANYTIME"
  }

  labels = var.labels
}

resource "yandex_mdb_mysql_database" "sql_db" {
  cluster_id = yandex_mdb_mysql_cluster.sql_cluster.id
  name       = var.database_name
}

resource "yandex_mdb_mysql_user" "sql_user" {
  cluster_id = yandex_mdb_mysql_cluster.sql_cluster.id
  name       = var.user_name
  password   = var.user_password

  permission {
    database_name = yandex_mdb_mysql_database.sql_db.name
    roles         = ["ALL"]
  }
}