### Ответы:

![image](https://github.com/user-attachments/assets/aea0ee55-8025-468c-87ff-3bf51ddeac07)

В соответствии с указанным .gitignore файлом, допустимо сохранять личную, секретную информацию в файле с именем "personal.auto.tfvars" в директории проекта

![image](https://github.com/user-attachments/assets/3135a682-2efb-405b-aa1d-aaad0ccb454b)

wYQn2CKFZnGegYV6

![image](https://github.com/user-attachments/assets/2df6e66b-cceb-4b8d-8773-1fb3df0045da)

Пропущено имя "docker_image"

![image](https://github.com/user-attachments/assets/71c50951-41f1-421c-949a-cab8cc67f075)

Перед nginx нужно убрать цифру, andom_string_FAKE не была объявлена, нужно удалить _FAKE, resulT меняем на result

![image](https://github.com/user-attachments/assets/13eb0021-ddac-47bb-952f-3e5f80380fa0)

![image](https://github.com/user-attachments/assets/60cd41d8-0f32-4081-a3a8-3e29444e329a)

![image](https://github.com/user-attachments/assets/2b20258e-0af8-4bf5-b771-0e4a57646042)
Если применять команду terraform apply -auto-approve, то мы не сможем проверить перед запуском все сценарии, которые выполняются.


```
---
{
  "version": 4,
  "terraform_version": "1.8.5",
  "serial": 7,
  "lineage": "87cfacd8-07d7-1a1c-fa0f-cde0065395d4",
  "outputs": {},
  "resources": [
    {
      "mode": "managed",
      "type": "docker_container",
      "name": "nginx",
      "provider": "provider[\"registry.terraform.io/kreuzwerker/docker\"]",
      "instances": [
        {
          "schema_version": 2,
          "attributes": {
            "attach": false,
            "bridge": "",
            "capabilities": [],
            "cgroupns_mode": null,
            "command": [
              "nginx",
              "-g",
              "daemon off;"
            ],
            "container_logs": null,
            "container_read_refresh_timeout_milliseconds": 15000,
            "cpu_set": "",
            "cpu_shares": 0,
            "destroy_grace_seconds": null,
            "devices": [],
            "dns": null,
            "dns_opts": null,
            "dns_search": null,
            "domainname": "",
            "entrypoint": [
              "/docker-entrypoint.sh"
            ],
            "env": [],
            "exit_code": null,
            "gpus": null,
            "group_add": null,
            "healthcheck": null,
            "host": [],
            "hostname": "261d53186fad",
            "id": "261d53186fad8a521512dc03b871237c69921f7ef50bcb3164f80107b141ab4a",
            "image": "sha256:53a18edff8091d5faff1e42b4d885bc5f0f897873b0b8f0ace236cd5930819b0",
            "init": false,
            "ipc_mode": "private",
            "labels": [],
            "log_driver": "json-file",
            "log_opts": null,
            "logs": false,
            "max_retry_count": 0,
            "memory": 0,
            "memory_swap": 0,
            "mounts": [],
            "must_run": true,
            "name": "hello_world",
            "network_data": [
              {
                "gateway": "172.17.0.1",
                "global_ipv6_address": "",
                "global_ipv6_prefix_length": 0,
                "ip_address": "172.17.0.2",
                "ip_prefix_length": 16,
                "ipv6_gateway": "",
                "mac_address": "6e:15:c5:22:1f:a1",
                "network_name": "bridge"
              }
            ],
            "network_mode": "bridge",
            "networks_advanced": [],
            "pid_mode": "",
            "ports": [
              {
                "external": 9090,
                "internal": 80,
                "ip": "0.0.0.0",
                "protocol": "tcp"
              }
            ],
            "privileged": false,
            "publish_all_ports": false,
            "read_only": false,
            "remove_volumes": true,
            "restart": "no",
            "rm": false,
            "runtime": "runc",
            "security_opts": [],
            "shm_size": 64,
            "start": true,
            "stdin_open": false,
            "stop_signal": "SIGQUIT",
            "stop_timeout": 0,
            "storage_opts": null,
            "systls": null,
            "tmpfs": null,
            "tty": false,
            "ulimit": [],
            "upload": [],
            "user": "",
            "userns_mode": "",
            "volumes": [],
            "wait": false,
            "wait_timeout": 60,
            "working_dir": ""
          },
          "sensitive_attributes": [],
          "private": "eyJzY2hlbWFfdmVyc2lvbiI6IjIifQ==",
          "dependencies": [
            "docker_image.nginx"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "docker_image",
      "name": "nginx",
      "provider": "provider[\"registry.terraform.io/kreuzwerker/docker\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "build": [],
            "force_remove": null,
            "id": "sha256:53a18edff8091d5faff1e42b4d885bc5f0f897873b0b8f0ace236cd5930819b0nginx:latest",
            "image_id": "sha256:53a18edff8091d5faff1e42b4d885bc5f0f897873b0b8f0ace236cd5930819b0",
            "keep_locally": true,
            "name": "nginx:latest",
            "platform": null,
            "pull_triggers": null,
            "repo_digest": "nginx@sha256:124b44bfc9ccd1f3cedf4b592d4d1e8bddb78b51ec2ed5056c52d3692baebc19",
            "triggers": null
          },
          "sensitive_attributes": [],
          "private": "bnVsbA=="
        }
      ]
    },
    {
      "mode": "managed",
      "type": "random_password",
      "name": "random_string",
      "provider": "provider[\"registry.terraform.io/hashicorp/random\"]",
      "instances": [
        {
          "schema_version": 3,
          "attributes": {
            "bcrypt_hash": "$2a$10$Yle8UWHFVDYiG0g2yKtide0yGi00TbJwT04AiuQDtA0NHlVQmSJhu",
            "id": "none",
            "keepers": null,
            "length": 16,
            "lower": true,
            "min_lower": 1,
            "min_numeric": 1,
            "min_special": 0,
            "min_upper": 1,
            "number": true,
            "numeric": true,
            "override_special": null,
            "result": "wYQn2CKFZnGegYV6",
            "special": false,
            "upper": true
          },
          "sensitive_attributes": [
            [
              {
                "type": "get_attr",
                "value": "bcrypt_hash"
              }
            ],
            [
              {
                "type": "get_attr",
                "value": "result"
              }
            ]
          ]
        }
      ]
    }
  ],
  "check_results": null
}
```

(Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.









