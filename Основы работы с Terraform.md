### Задание 1
![image](https://github.com/user-attachments/assets/53ac3e22-87b4-4190-91e2-5f409aeabc7d)
![image](https://github.com/user-attachments/assets/14ee4634-25a4-4802-a345-ced98ec0a1cc)

В строке platform_id = "standart-v4" ошибка, должно быть слово standard. v4 - неправильно, в яндексе только 3.
В строке cores 1 это неправильно, минимальные требования 2

Параметр preemptible = true применяется в том случае, если нужно сделать виртуальную машину прерываемой, то есть возможность остановки ВМ в любой момент. Применятся если с момента запуска машины прошло 24 часа либо возникает нехватка ресурсов для запуска ВМ. Прерываемые ВМ не обеспечивают отказоустойчивость.

Параметр core_fraction=5 указывает базовую производительность ядра в процентах. Указывается для экономии ресурсов.


### Задание 2

Изменила хардкод на переменные.
```
main.tf

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family
}

resource "yandex_compute_instance" "platform" {
  name        = var.vm_web_name
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vm_web_cores
    memory        = var.vm_web_memory
    core_fraction = var.vm_web_core_fraction
  }
```
```
variables.tf

variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Ububnu Version"
}

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Instant Name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Platform ID"
}

variable "vm_web_cores" {
  type        = string
  default     = "2"
  description = "vCPU"
}

variable "vm_web_memory" {
  type        = string
  default     = "1"
  description = "VM memory, Gb"
}

variable "vm_web_core_fraction" {
  type        = string
  default     = "5"
  description = "core fraction, %"
}
```


![image](https://github.com/user-attachments/assets/c1716191-2b0c-4ee1-8b8d-a7727f16b56c)

### Задание 3

vms_platform.tf
```
variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Ububnu Version"
}

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Instant Name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Platform ID"
}

variable "vm_web_cores" {
  type        = string
  default     = "2"
  description = "vCPU"
}

variable "vm_web_memory" {
  type        = string
  default     = "1"
  description = "VM memory, Gb"
}

ariable "vm_web_core_fraction" {
  type        = string
  default     = "5"
  description = "core fraction, %"
}

variable "vm_db_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Ubuntu Version"
}

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Instant Name"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Platform ID"
}

variable "vm_db_cores" {
  type        = string
  default     = "2"
  description = "vCPU"
}

variable "vm_db_memory" {
  type        = string
  default     = "2"
  description = "VM memory, Gb"
}

variable "vm_db_core_fraction" {
  type        = string
  default     = "20"
  description = "core fraction, %"
}
```

main.tf
```
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family
}

resource "yandex_compute_instance" "platform" {
  name        = var.vm_web_name
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vm_web_cores
    memory        = var.vm_web_memory
    core_fraction = var.vm_web_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
}

data "yandex_compute_image" "ubuntu2" {
  family = var.vm_db_family
}

resource "yandex_compute_instance" "platform2" {
  name        = var.vm_db_name
  platform_id = var.vm_db_platform_id
  resources {
    cores         = var.vm_db_cores
    memory        = var.vm_db_memory
    core_fraction = var.vm_db_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
}
```
![image](https://github.com/user-attachments/assets/69516cf1-417e-4add-aa33-7d19d44f1e55)


### Задание 4





