###cloud vars
#MAIN
variable "token" {
  type        = string
  description = "export TF_VAR_token=$(yc iam create-token)"
}

variable "cloud_id" {
  type        = string
  description = "export TF_VAR_cloud_id=$(yc config get cloud-id)"
}

variable "folder_id" {
  type        = string
  description = "export TF_VAR_folder_id=$(yc config get folder-id)"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

#VPC
variable "subnets" {
  description = "Описание подсетей"
  type = map(object({
    name        = string
    description = optional(string)
    zone        = string
    cidr_blocks = list(string)
  }))
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

#VMS
variable "vms_ssh_root_key" {
  type        = string
  description = "export TF_VAR_vms_ssh_root_key='$(cat ~/.ssh/key_yc_terraform.pub)'"
}

variable "vms_ssh_private_key" {
  type        = string
  description = "Путь к приватному ключу"
}

variable "ssh_username" {
  description = "Имя пользователя SSH"
  type        = string
  default     = "ubuntu"
}

variable "vms" {
  description = "Конфиг виртуальных машин (копия модуля)"

  type = map(object({
    name          = string
    hostname      = optional(string)
    subnet_key    = string
    cores         = optional(number, 2)
    memory        = optional(number, 2)
    core_fraction = optional(number, 20)
    disk_size     = optional(number, 15)
    disk_type     = optional(string, "network-hdd")
    nat           = optional(bool, true)
    labels        = optional(map(string), {})
  }))
}

#REGISTRY
variable "registry_name" {
  description = "Название Регистри"
  type        = string
  default     = "terraform-final-registry"
}


#MYSQL
variable "db_cluster_name" {
  description = "Название mysql кластера"
  type        = string
  default     = "terraform-mysql"
}

variable "db_name" {
  description = "Название базы данных"
  type        = string
  default     = "application_db"
}

variable "db_user" {
  description = "Имя пользователя базы данных"
  type        = string
  default     = "application_user"
}

variable "db_password" {
  description = "Пароль пользователя базы данных"
  type        = string
  sensitive   = true
}