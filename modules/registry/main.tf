resource "yandex_container_registry" "registry" {
  name      = var.reg_name
  folder_id = var.folder_id
  labels    = var.labels
}

resource "yandex_container_repository" "repository" {
  count = var.repository_name == null ? 0 : 1

  name = "${yandex_container_registry.registry.id}/${var.repository_name}"
}