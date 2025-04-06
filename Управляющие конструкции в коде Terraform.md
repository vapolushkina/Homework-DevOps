### Задача 1
![image](https://github.com/user-attachments/assets/b6acd022-cd8a-4834-a5bd-232de009f9a5)
![image](https://github.com/user-attachments/assets/e862bf33-7ebb-4d15-bc11-82f88a66b388)
![image](https://github.com/user-attachments/assets/812e384d-9849-4333-bb12-c9f89d60ed2c)

### Задача 2

count-vm.tf
```
variable "os_web" {
  type    = string
  default = "ubuntu-2204-lts"
}

data "yandex_compute_image" "ubuntu-2204-lts" {
  family = var.os_web
}

variable "yandex_compute_instance_web" {
  type        = list(object({
    vm_name = string
    cores = number
    memory = number
    core_fraction = number
    count_vms = number
    platform_id = string
  }))

  default = [{
      vm_name = "web"
      cores         = 2
      memory        = 1
      core_fraction = 5
      count_vms = 2
      platform_id = "standard-v1"
    }]
}
locals {
  ssh-keys = file("~/.ssh/id_ed25519.pub")
}
variable "boot_disk_web" {
  type        = list(object({
    size = number
    type = string
    }))
    default = [ {
    size = 8
    type = "network-hdd"
  }]
}

resource "yandex_compute_instance" "web" {
  name        = "${var.yandex_compute_instance_web[0].vm_name}-${count.index+1}"
  platform_id = var.yandex_compute_instance_web[0].platform_id

  count = var.yandex_compute_instance_web[0].count_vms

  resources {
    cores         = var.yandex_compute_instance_web[0].cores
    memory        = var.yandex_compute_instance_web[0].memory
    core_fraction = var.yandex_compute_instance_web[0].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2204-lts.image_id
      type     = var.boot_disk_web[0].type
      size     = var.boot_disk_web[0].size
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${дщсфд.ssh-keys}"
    serial-port-enable = "1"
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [
      yandex_vpc_security_group.example.id
    ]
  }

  scheduling_policy {
    preemptible = true
  }
}
```

for_each-vm.tf
```
variable "os_image" {
  type = string
  default = "ubuntu-2204-lts"
}

data "yandex_compute_image" "ubuntu" {
  family = var.os_image
}

variable "vm_resources" {
  type = list(object({
    vm_name = string
    cpu     = number
    ram     = number
    disk    = number
    platform_id = string
  }))

  default = [
    {
      vm_name = "main"
      cpu     = 2
      ram     = 2
      disk    = 8
      platform_id = "standard-v1"
    },
    {
      vm_name = "replica"
      cpu     = 2
      ram     = 2
      disk    = 10
      platform_id = "standard-v1"
    },
  ]
}

locals {
  ssh-keys = file("~/.ssh/id_ed25519.pub")
}

resource "yandex_compute_instance" "for_each" {
  depends_on = [yandex_compute_instance.web]
  for_each = { for i in var.vm_resources : i.vm_name => i }
  name          = each.value.vm_name

  platform_id = each.value.platform_id
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = each.value.disk
    }
  }

    metadata = {
    ssh-keys = "ubuntu:${local.ssh-keys}"
    serial-port-enable = "1"
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [
      yandex_vpc_security_group.example.id
    ]
  }
  scheduling_policy {
    preemptible = true
  }
}
```

ВМ БД создаются раньше чем вэб:
```
resource "yandex_compute_instance" "for_each" {
  depends_on = [yandex_compute_instance.web]
  for_each = { for i in var.vm_resources : i.vm_name => i }
  name          = each.value.vm_name
```

Функция file
```
locals {
  ssh-keys = file("~/.ssh/id_ed25519.pub")
}
    metadata = {
    ssh-keys = "ubuntu:${local.ssh-keys}"
    serial-port-enable = "1"
  }
```
![image](https://github.com/user-attachments/assets/6d55396e-3a98-4dbc-980c-9bebba63932d)

### Задача 3

disk_vm.tf
```
variable "storage_secondary_disk" {
  type = list(object({
    for_storage = object({
      type       = string
      size       = number
      count      = number
      block_size = number
      name = string
    })
  }))

  default = [
    {
      for_storage = {
        type       = "network-hdd"
        size       = 1
        count      = 3
        block_size = 4096
        name = "disk"
      }
    }
  ]
}

resource "yandex_compute_disk" "disks" {
  name  = "${var.storage_secondary_disk[0].for_storage.name}-${count.index+1}"
  type  = var.storage_secondary_disk[0].for_storage.type
  size  = var.storage_secondary_disk[0].for_storage.size
  count = var.storage_secondary_disk[0].for_storage.count
  block_size  = var.storage_secondary_disk[0].for_storage.block_size
}
variable "yandex_compute_instance_storage" {
  type = object({
    storage_resources = object({
      cores        = number
      memory       = number
      core_fraction = number
      name         = string
      zone         = string
    })
  })

  default = {
    storage_resources = {
      cores        = 2
      memory       = 2
      core_fraction = 5
      name         = "storage"
      zone         = "ru-central1-a"
    }
  }
}

variable "boot_disk_storage" {
  type = object({
    size = number
    type = string
  })
  default = {
    size = 8
    type = "network-hdd"
  }
}

resource "yandex_compute_instance" "storage" {
  name = var.yandex_compute_instance_storage.storage_resources.name
  zone = var.yandex_compute_instance_storage.storage_resources.zone

  resources {
    cores  = var.yandex_compute_instance_storage.storage_resources.cores
    memory = var.yandex_compute_instance_storage.storage_resources.memory
    core_fraction = var.yandex_compute_instance_storage.storage_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2204-lts.image_id
      type     = var.boot_disk_storage.type
      size     = var.boot_disk_storage.size
    }
  }
      metadata = {
      ssh-keys           = "ubuntu:${local.ssh-keys}"
      serial-port-enable = "1"
    }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [
      yandex_vpc_security_group.example.id
    ]
  }
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disks.*.id
    content {
      disk_id = secondary_disk.value
  }
  }
}
resource "null_resource" "web_hosts_provision" {
  depends_on = [yandex_compute_instance.storage]
  provisioner "local-exec" {
    command = "cat ~/.ssh/id_ed25519 | ssh-add -"
  }
  
  provisioner "local-exec" {
    command = "sleep 120"
  }

  provisioner "local-exec" {
    command  = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/hosts.cfg ${abspath(path.module)}/test.yml"
    on_failure = continue 
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
  }
    triggers = {
      always_run         = "${timestamp()}"
      playbook_src_hash  = file("${abspath(path.module)}/test.yml") 
      ssh_public_key     = local.ssh-keys 
    }
  }
```

![image](https://github.com/user-attachments/assets/6d648711-3b8b-4d3f-88c7-388bd5c125f9)

### Задача 4

ansible.tf
```
resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl",
   {webservers =  yandex_compute_instance.web
    databases = yandex_compute_instance.for_each
    storage = [yandex_compute_instance.storage]}
  )
  filename = "${abspath(path.module)}/hosts.cfg"
}
```

hosts.tftpl
```
[webservers]
%{~ for i in webservers ~}
${i["name"]}   ansible_host=${i["network_interface"][0]["nat_ip_address"]==null ? i["network_interface"][0]["ip_address"] : i["network_interface"][0]["nat_ip_address"]}
%{~ endfor ~}

[databases]
%{~ for i in databases ~}
${i["name"]}   ansible_host=${i["network_interface"][0]["nat_ip_address"]==null ? i["network_interface"][0]["ip_address"] : i["network_interface"][0]["nat_ip_address"]}
%{~ endfor ~}

[storage]
%{~ for i in storage ~}
${i["name"]}   ansible_host=${i["network_interface"][0]["nat_ip_address"]==null ? i["network_interface"][0]["ip_address"] : i["network_interface"][0]["nat_ip_address"]}
%{~ endfor ~}
```
![image](https://github.com/user-attachments/assets/764b795d-8f25-4ce7-abd4-89861ea04f66)
