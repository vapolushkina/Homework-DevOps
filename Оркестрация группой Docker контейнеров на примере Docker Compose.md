Домашнее задание к занятию 4 «Оркестрация группой Docker контейнеров на примере Docker Compose»

### Задача 1

https://hub.docker.com/repository/docker/vapolushkina/custom-nginx/general

---
### Задача 2

![image](https://github.com/vapolushkina/Homework-DevOps/assets/121248099/5ce5d09d-edad-4988-8d69-29ea2efa65da)

![image](https://github.com/vapolushkina/Homework-DevOps/assets/121248099/b48f2ffa-95bc-4ba5-843a-d7a548d85f6d)


---
### Задача 3

![image](https://github.com/user-attachments/assets/d46f8dfe-93e9-4a40-9f15-59c605f589a7)

Команда Ctrl+C останавливает контейнер Docker, потому что при её нажатии в терминал отправляется сигнал SIGINT, который запрашивает остановку или завершение контейнера. Сигнал SIGINT в системах Linux означает остановку процесса пользователем с терминала.

Вопрос: Отредактируйте файл "/etc/nginx/conf.d/default.conf", заменив порт "listen 80" на "listen 81".
У меня файл отсутствовал, я его создала, но при выполнении указанных команд вот что я вижу:
![image](https://github.com/user-attachments/assets/75152473-5984-40ed-939f-61096ed8eff6)
![image](https://github.com/user-attachments/assets/1dfab98d-d88f-48d1-ba5e-b7a2934d96cb)

В контейнере сейчас доступно 2 порта, предполагаю, что это потому что 80й я прописала при создании Dockerfile:
![image](https://github.com/user-attachments/assets/2e4bbfcd-a691-4e0a-bfba-c6c9915bb3e0)

Я правильно понимаю, что по 80му порту должно было перестать работать отображение страницы потому что порт был изменен?

Для удаления контейнера используется команда docker rm -f


---
### Задача 4
![image](https://github.com/user-attachments/assets/25c02c77-ab53-4719-95a9-e7479d877224)
![image](https://github.com/user-attachments/assets/23926c35-1850-4da0-9d20-fcd4bb07636e)
![image](https://github.com/user-attachments/assets/07c88a6e-a05b-4b6b-84da-a7f8f223fde6)
![image](https://github.com/user-attachments/assets/ab45bcdc-b917-4239-bc7e-2493b10cdb70)


---
### Задача 5
![image](https://github.com/user-attachments/assets/6ce4c8c5-034c-4efc-97e5-b05470628824)
![image](https://github.com/user-attachments/assets/32ae0d37-0789-472b-90fc-09a7569460c3)
Путь по умолчанию для файла Compose — compose.yaml(предпочтительно) или compose.yml, который находится в рабочем каталоге. Compose также поддерживает docker-compose.yamlи docker-compose.ymlдля обратной совместимости с более ранними версиями. Если существуют оба файла, Compose предпочитает канонический compose.yaml.

![image](https://github.com/user-attachments/assets/1707ff91-7569-4800-ba9f-78dc57747729)
![image](https://github.com/user-attachments/assets/d560e15b-a60d-424e-b33f-0aa6c56ba435)
![image](https://github.com/user-attachments/assets/a203cb65-86ec-4ef1-a881-f388a221d38f)
![image](https://github.com/user-attachments/assets/f8f4283c-fddd-4c57-8ea3-908a9aa967b4)
![image](https://github.com/user-attachments/assets/2818c40e-e8ef-4ed8-8be7-c609099b89db)
![image](https://github.com/user-attachments/assets/b33e1cb3-facf-4dc2-b1c3-7695582cf21f)













