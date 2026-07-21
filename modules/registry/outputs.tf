output "registry_id" {
  description = "ID Container Registry"
  value       = yandex_container_registry.registry.id
}

output "registry_url" {
  description = "Адрес Container Registry"
  value       = "cr.yandex/${yandex_container_registry.registry.id}"
}

output "repository_name" {
  description = "Полное имя репозитория"
  value = try(
    yandex_container_repository.repository[0].name,
    null
  )
}