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







