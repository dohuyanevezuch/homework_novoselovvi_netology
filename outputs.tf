output "marketing" {

  value = [
    for vm in module.marketing_vm.all : {
      name        = vm.name
      external_ip = vm.network_interface[0].nat_ip_address
      labels      = vm.labels
      ssh_connect = "ssh -i ~/.ssh/key_yc_terraform ubuntu@${vm.network_interface[0].nat_ip_address}"
    }
  ]
}

output "analytics" {

  value = [
    for vm in module.analytics_vm.all : {
      name        = vm.name
      external_ip = vm.network_interface[0].nat_ip_address
      labels      = vm.labels
      ssh_connect = "ssh -i ~/.ssh/key_yc_terraform ubuntu@${vm.network_interface[0].nat_ip_address}"
    }
  ]
}