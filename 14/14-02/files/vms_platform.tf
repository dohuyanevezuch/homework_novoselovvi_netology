#vm_all
variable "school_name" {
  type = string
  default = "netology"
}
variable "platform_name" {
  type    = string
  default = "platform"
}
variable "vm_platform" {
  type = string
  description = "Вид физического процессора"
  default = "standard-v3"
}

variable "vms_resoucres" {
    description = "Ресурсы обеих VM"

    type = map(object({
        cores = number
        memory = number
        core_fraction = number
    }))
    default = {
      "web" = {
        cores = 2
        memory = 1
        core_fraction = 50
      }
      "db" = {
        cores = 2
        memory = 2
        core_fraction = 20
      }
    }
}

variable "metadata" {
    type = map(string)
}

#vm_web
variable "id_name_web" {
    type    = string
    default = "web"
}

variable "vm_web_platform" {
  type = string
  description = "Вид физического процессора"
  default = "standard-v3"
}

/*variable "vm_web_resources" {
  type = object({
    cores = number
    memory = number
    core_fraction = number
  })
  description = "Ресурсы ВМ"

  default = {
    cores = 2
    memory = 1
    core_fraction = 50
  }
} */

# vm_db
variable "id_name_db" {
    type    = string
    default = "db"
}
/*variable "vm_db_platform" {
  type = string
  description = "Вид физического процессора"
  default = "standard-v3"
}
variable "vm_db_resources" {
  type = object({
    cores = number
    memory = number
    core_fraction = number
  })
  description = "Ресурсы ВМ"

  default = {
    cores = 2
    memory = 2
    core_fraction = 20
  }
} */
