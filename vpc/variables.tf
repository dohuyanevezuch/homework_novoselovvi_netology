variable "env_name" {
  type        = string
  description = "Название VPC"

  validation {
    condition     = length(trimspace(var.env_name)) > 0
    error_message = "Название не должно быть пустым."
  }
}

variable "zone" {
  type        = string
  description = "Зона доступности для подсети, например ru-central1-a"

  validation {
    condition     = length(trimspace(var.zone)) > 0
    error_message = "Зона не должна быть пустой."
  }
}

variable "v4_cidr_blocks" {
  type        = list(string)
  description = "Список IPv4 CIDR-блоков подсети"

  validation {
    condition     = length(var.v4_cidr_blocks) > 0
    error_message = "Не должен быть пустой."
  }
}