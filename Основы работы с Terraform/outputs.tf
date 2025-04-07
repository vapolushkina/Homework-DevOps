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
