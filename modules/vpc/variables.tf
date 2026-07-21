variable "vpc_name" {
  description = "Название VPC"
  type        = string
}

variable "subnets" {
  description = "Список создаваемых подсетей"

  type = map(object({
    name        = string
    description = optional(string)
    zone        = string
    cidr_blocks = list(string)
  }))
}

variable "security_group_name" {
  description = "Название группы безопасности"
  type        = string
  default     = "netology-sg"
}

variable "allow_ports" {
  description = "Список разрешенных входящих портов"
  type        = list(number)
  default     = [22]
}

variable "labels" {
  description = "Метки ресурсов"
  type        = map(string)
  default     = {}
}

variable "allowed_cidrs" {
  description = "CIDR, с которых разрешён входящий трафик"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}