locals {
  default_os = data.yandex_compute_image.ubuntu.image_id

  ssh_pub = file("~/.ssh/key_yc_terraform.pub")

  all_vms = concat(
    yandex_compute_instance.vms_web,
    values(yandex_compute_instance.vms_db),
    [yandex_compute_instance.storage]
  )
}