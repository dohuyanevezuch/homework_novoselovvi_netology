output "cluster_id" {
  description = "ID MySQL-кластера"
  value       = yandex_mdb_mysql_cluster.sql_cluster.id
}

output "database_name" {
  description = "Название базы данных"
  value       = yandex_mdb_mysql_database.sql_db.name
}

output "user_name" {
  description = "Имя пользователя MySQL"
  value       = yandex_mdb_mysql_user.sql_user.name
}

output "hosts" {
  description = "Список FQDN MySQL-хостов"

  value = [
    for host in yandex_mdb_mysql_cluster.sql_cluster.host :
    host.fqdn
  ]
}