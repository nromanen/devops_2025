
- Kotlin
- Spring Boot (MVC)
- Thymeleaf
- Gradle (Kotlin DSL)
- Vagrant (для dev-середовища)
- HTML/CSS (basic)

###  Клонування репозиторію

bash
git clone https://github.com/DevOps1-Fundamentals/vagrant-Merida39
cd your-dogs-repo


### Запуск через Vagrant

bash
vagrant up
vagrant ssh
cd /vagrant
./gradlew bootRun


## Структура проєкту

src/
├── main/
│   ├── kotlin/academy/softserve/dogs/
│   │   ├── DogsApplication.kt
│   │   ├── model/Dog.kt
│   │   ├── service/DogService.kt
│   │   └── DogController.kt
│   ├── resources/
│   │   ├── static/images/dog/       
│
├── build.gradle.kts
├── settings.gradle.kts
└── Vagrantfile


## Дані собак

Собаки захардкожені у `DogService.kt` (mock). Кожен пес має:

- ім’я
- стать
- вік
- опис
- шлях до фото (наприклад: `/images/dog/p1.jpeg`)


https://drive.google.com/file/d/1RZFzLKO1chWML4WOkie2MZCvpS-P5VJb/view






