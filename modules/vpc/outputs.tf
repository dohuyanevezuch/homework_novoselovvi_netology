output "network_id" {
  value = yandex_vpc_network.net.id
}

output "subnet_ids" {
  value = {
    for key, subnet in yandex_vpc_subnet.subnet :
    key => subnet.id
  }
}

output "security_group_id" {
  value = yandex_vpc_security_group.sg.id
}

output "mysql_security_group_id" {
  description = "ID группы безопасности MySQL"
  value       = yandex_vpc_security_group.mysql_sg.id
}