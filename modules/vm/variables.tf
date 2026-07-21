variable "instances" {
  description = "Конфигурация виртуальных машин"

  type = map(object({
    name          = string
    hostname      = optional(string)
    zone          = string
    subnet_id     = string
    cores         = optional(number, 2)
    memory        = optional(number, 2)
    core_fraction = optional(number, 20)
    disk_size     = optional(number, 15)
    disk_type     = optional(string, "network-hdd")
    nat           = optional(bool, true)
    labels        = optional(map(string), {})
  }))
}

variable "image_id" {
  description = "ID образа операционной системы"
  type        = string
}

variable "platform_id" {
  description = "Платформа виртуальных машин"
  type        = string
  default     = "standard-v3"
}

variable "security_group_ids" {
  description = "Группы безопасности для VM"
  type        = list(string)
  default     = []
}

variable "ssh_username" {
  description = "Пользователь для SSH"
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key" {
  description = "Содержимое публичного SSH-ключа"
  type        = string
}

variable "user_data" {
  description = "Cloud-init конфигурация"
  type        = string
  default     = null
}

variable "service_account_id" {
  description = "ID сервисного аккаунта, привязанного к VM"
  type        = string
  default     = null
}