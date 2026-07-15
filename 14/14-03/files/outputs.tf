output "vm_list" {
    value = [
        for vm in local.all_vms : {
            name = vm.name
            id = vm.id
            fqdn = vm.fqdn
        }
    ]
}