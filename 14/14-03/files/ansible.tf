resource "local_file" "hosts_templatefile" {

  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = yandex_compute_instance.vms_web
    databases  = values(yandex_compute_instance.vms_db)
    storage    = [yandex_compute_instance.storage]
  })

  filename = "${abspath(path.module)}/hosts.ini"
}