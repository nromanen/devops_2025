# 🛠️ Завдання 14: Build Tools (Webpack + Gradle)

Цей проєкт — частина навчання в SoftServe IT Academy (DevOps Fundamentals) і демонструє повну інтеграцію фронтенду на Webpack з бекендом на Spring Boot (Kotlin), з використанням Gradle як інструменту зборки.

---

## 📁 Структура проєкту

andrii_labych/ ├── build.gradle.kts # Gradle налаштування ├── settings.gradle.kts ├── src/ │ └── main/ │ ├── kotlin/com/example/ │ │ ├── BootAppApplication.kt │ │ └── DogsController.kt │ └── resources/static/ │ └── (згенерований Webpack UI) ├── ui/ # Фронтенд частина │ ├── src/ │ │ ├── index.html │ │ ├── index.js │ │ └── style.css │ ├── package.json │ └── webpack.config.js


---

##  Функціонал

- **Webpack** збирає фронтенд з `src/index.js`, `index.html` і `style.css`
- **Gradle** запускає Webpack як частину збірки
- **REST API** на `/api/dogs` повертає список песиків
- **UI** показує імена та фото песиків

---

## Запуск проєкту

1. **Перехід до кореня:**
   ```bash
   cd andrii_labych
## Збірка ./gradlew bootRun
## Відкрити у браузері http://localhost:8080

## Використано:
Kotlin + Spring Boot (WebFlux)

Gradle Kotlin DSL

Node.js + Webpack

HTML + JS + CSS

https://drive.google.com/file/d/1q09IBWY1YLM6EE45Eu1xJ6D7cyn9BUGp/view