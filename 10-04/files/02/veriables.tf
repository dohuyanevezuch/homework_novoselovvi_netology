variable "cloud_id" {
  type    = string
  default = "b1gnvvcq6rkmbooec0p2"
}
variable "folder_id" {
  type    = string
  default = "b1guqjkhvp7tl2op7tin"
}
variable "location_zone" {
    type = string
    default = "ru-central1-b"
}
data "yandex_compute_image" "ubuntu_2204_lts" {
    family = "ubuntu-2204-lts"
}
data "yandex_iam_service_account" "admin" {
  name        = "admin"
  folder_id = var.folder_id
}