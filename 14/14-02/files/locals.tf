locals {
  netology_vm_web_name = "${var.school_name}-${var.vpc_name}-${var.platform_name}-${var.id_name_web}"
  netology_vm_db_name = "${var.school_name}-${var.vpc_name}-${var.platform_name}-${var.id_name_db}"
}