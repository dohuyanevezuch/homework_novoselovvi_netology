output "network_id" {
  description = "id VPC"
  value       = yandex_vpc_network.develop.id
}

output "subnet_id" {
  description = "id subnet"
  value       = yandex_vpc_subnet.develop.id
}

output "subnet" {
  description = "информация о yandex_vpc_subnet"
  value       = yandex_vpc_subnet.develop
}