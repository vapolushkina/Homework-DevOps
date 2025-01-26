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

Я правильно понимаю, что по 80му порту должно было перестать работать отображение страницы?









