variable "reg_name" {
  description = "Название Container Registry"
  type        = string
}

variable "folder_id" {
  description = "ID каталога Yandex Cloud"
  type        = string
}

variable "labels" {
  description = "Метки Container Registry"
  type        = map(string)
  default     = {}
}

variable "repository_name" {
  description = "Название репозитория внутри Registry"
  type        = string
  default     = null
}