# This is DevOps-School-Final-Project
Это квалификационная работа по курсу DevOps инженер от DevopsSchool https://devops-school.ru/devops_engineer.html

Двнный проект - это pipeline для Jenkins, запускающий Terraform для создания инфраструктуры в AWS, состоящей из двух инстансов. На первом инстансе (build) с помощью Ansible создается сборочное окружение, в котором собирается Docker образ с Java приложением и пушится в DockerHub. На втором инстансе (stage) это приложение запускается в созданном контейнере.

Для запуска проекта требутся:
- установленный Jenkins с плагинами Git, Pipeline
- учетная запись AWS IAM с правами для создания EC2 инстансов
- на сборочной ноде Jenkins также должны быть установлены Terraform и Ansible
- учетная запись на DockerHub

1. Создать Jenkins Job тип Pipeline
2. Поставить чекбокс # This project is parameterized
   - Add parametr -> Password Parametr
   - Name AWS_ACCESS_KEY_ID
   - Default Value {YOUR_AWS_ACCESS_KEY_ID}
   - Add parametr -> Password Parametr
   - Name AWS_SECRET_ACCESS_KEY
   - Default Value {YOUR_AWS_SECRET_ACCESS_KEY}
   - Эти параметры будут доступны для сборки как переменные среды.
3. Выбрать "Pipeline script from SCM" -> SCM - Git -> указать URL данного репозитория.
4. Для того, чтобы запушить образ в DockerHub, необходимо указать credentials
   - ansible-vault encrypt_string
   - {YOUR_DOCKERHUB_LOGIN}
   - ansible-vault encrypt_string
   - {YOUR_DOCKERHUB_PASSWORD}
   - скопировать шифрованные строки в ./create_and_push_image/vars/main.yml
                                    ./pull_image_and_run_container/vars/main.yml
   - файл с паролем docker.pass должен лежать в /var/lib/jenkins/workspace/YOUR_PIPELINE_NAME
5. Запустить Pipeline

![Screenshot 2021-07-10 at 18-26-21 Test-Pipeline1  Jenkins](https://user-images.githubusercontent.com/70564689/125168546-bc05fc00-e1ae-11eb-9e18-031fab37d603.png)



