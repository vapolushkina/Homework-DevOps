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
resource "yandex_vpc_network" "develop1" {
  name = var.vpc_name1
}

resource "yandex_vpc_subnet" "develop1" {
  name           = var.vpc_name1
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr1
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
    subnet_id = yandex_vpc_subnet.develop1.id
    nat       = true
  }
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
}
```
variables.tf
```
variable "cloud_id" {
  type        = string
  description = "-"
}

variable "folder_id" {
  type        = string
  description = "-"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "default_cidr1" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vpc_name1" {
  type        = string
  default     = "develop1"
  description = "VPC network & subnet name"
}
```

![image](https://github.com/user-attachments/assets/67faecc9-0bb4-47a6-abb9-d1d71f096a25)



### Задание 4

```
output "My_vm" {
  value = {
    instance_name1 = yandex_compute_instance.platform.name
    exterrnal_ip1 = yandex_compute_instance.platform.network_interface.0.nat_ip_address
    instance_name2 = yandex_compute_instance.platform2.name
    exterrnal_ip2 = yandex_compute_instance.platform2.network_interface.0.nat_ip_address
  }
}
```
![image](https://github.com/user-attachments/assets/77901112-92b1-47f0-bdbc-8c884a111903)


### Задание 5

![image](https://github.com/user-attachments/assets/5d81276f-f8fb-407d-b438-ab09447a42f0)

![image](https://github.com/user-attachments/assets/2396e9b9-7384-4ada-80ca-a1ac7798be57)

![image](https://github.com/user-attachments/assets/aa8d6129-c70f-466b-bad4-ed0f6693ee56)

![image](https://github.com/user-attachments/assets/6e35fffe-5477-470b-936a-b9e776fbe0a3)


### Задание 6

![image](https://github.com/user-attachments/assets/01b50518-0fba-453c-8238-8c2cb405f0f8)

![image](https://github.com/user-attachments/assets/3de05448-c224-47ee-ba55-16919230465c)

![image](https://github.com/user-attachments/assets/cf57f320-19ea-4be8-bb2f-ad90fdc06765)


![image](https://github.com/user-attachments/assets/8beb9b4b-3ae5-412a-887a-f864b06871e4)












