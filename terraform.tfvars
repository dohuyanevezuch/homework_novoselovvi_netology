#count_vm
count_vm = {
  resources = {
    cores         = 2
    memory        = 2
    core_fraction = 50
  }
  
  preemptible = true

  disk = {
    size = 20
    type = "network-hdd"
  }

  net = {
    nat = true
  }
}

#each_vm
each_vm = [
  {
    vm_name = "main"
    cpu = 4
    ram = 4
    cpu_frac = 50
    preemptible = true
    disk_volume = 25
    disk_type = "network-hdd"
    nat = true
  },
  {
    vm_name = "replica"
    cpu = 2
    ram = 2
    cpu_frac = 20
    preemptible = true
    disk_volume = 15
    disk_type = "network-hdd"
    nat = true
  }
]

