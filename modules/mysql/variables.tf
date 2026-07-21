variable "cluster_name" {
  description = "Название MySQL-кластера"
  type        = string
}

variable "network_id" {
  description = "ID сети VPC"
  type        = string
}

variable "subnet_id" {
  description = "ID подсети для MySQL"
  type        = string
}

variable "zone" {
  description = "Зона доступности MySQL-хоста"
  type        = string
}

variable "security_group_ids" {
  description = "ID групп безопасности MySQL"
  type        = list(string)
  default     = []
}

variable "environment" {
  description = "Окружение MySQL-кластера"
  type        = string
  default     = "PRESTABLE"

  validation {
    condition = contains(
      ["PRESTABLE", "PRODUCTION"],
      var.environment
    )

    error_message = "environment должен быть PRESTABLE или PRODUCTION."
  }
}

variable "mysql_version" {
  description = "Версия MySQL"
  type        = string
  default     = "8.0"
}

variable "resource_preset_id" {
  description = "Класс вычислительных ресурсов MySQL"
  type        = string
  default     = "s2.micro"
}

variable "disk_type_id" {
  description = "Тип диска MySQL"
  type        = string
  default     = "network-ssd"
}

variable "disk_size" {
  description = "Размер диска в ГБ"
  type        = number
  default     = 15
}

variable "assign_public_ip" {
  description = "Назначать ли MySQL публичный IP"
  type        = bool
  default     = false
}

variable "database_name" {
  description = "Название базы данных"
  type        = string
}

variable "user_name" {
  description = "Имя пользователя MySQL"
  type        = string
}

variable "user_password" {
  description = "Пароль пользователя MySQL"
  type        = string
  sensitive   = true
}

variable "backup_retain_period_days" {
  description = "Количество дней хранения резервных копий"
  type        = number
  default     = 7
}

variable "deletion_protection" {
  description = "Защита кластера от удаления"
  type        = bool
  default     = false
}

variable "labels" {
  description = "Метки MySQL-кластера"
  type        = map(string)
  default     = {}
}