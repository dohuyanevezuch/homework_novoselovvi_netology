output "registry_id" {
  description = "ID Container Registry"
  value       = module.registry.registry_id
}

output "registry_url" {
  description = "Адрес Container Registry"
  value       = module.registry.registry_url
}

output "repository_name" {
  description = "Название репозитория"
  value       = module.registry.repository_name
}

output "mysql_cluster_id" {
  description = "ID MySQL-кластера"
  value       = module.mysql.cluster_id
}

output "mysql_hosts" {
  description = "FQDN MySQL-хостов"
  value       = module.mysql.hosts
}

output "mysql_database_name" {
  description = "Название базы данных"
  value       = module.mysql.database_name
}

output "ssh_connect_commands" {
  description = "Команды для подключения к VM по SSH"

  value = {
    for vm_key, external_ip in module.vm.external_ip_addresses :
    vm_key => "ssh -i ${var.vms_ssh_private_key} ${var.ssh_username}@${external_ip}"
  }
}

output "mysql_user_name" {
  description = "Имя пользователя MySQL"
  value       = module.mysql.user_name
}

output "vm_external_ip_addresses" {
  description = "Публичные ip вм"
  value       = module.vm.external_ip_addresses
}

output "application_image" {
  description = "Адрес docker образа приложения"
  value       = "${module.registry.registry_url}/application:1.0"
}