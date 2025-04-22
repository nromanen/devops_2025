# Task #14 - Build Tools (Webpack + Gradle)

---

## Webpack config part 1

```bash
ui/webpack.config.js
```

### Config include 

entry point
output file
Output directory

Plugins
    HtmlWebpackPlugin (to copy ui/src/index.html to the ui/dist )
    CopyWebpackPlugin (to copy ui/src/style.css to the ui/dist/css)


### Build 

```bash
cd ui
npm install
npm run build
```


## Gradle Configuration

```bash
build.gradle.kts
```

```kotlin
tasks.register<Exec>("npmInstall") {
    workingDir = file("ui")
    commandLine("npm", "i")
}

tasks.register<Exec>("compileUi") {
    workingDir = file("ui")
    commandLine("npm", "run", "build")
    dependsOn("npmInstall")
}

tasks.register<Copy>("copyUi") {
    dependsOn("compileUi")
    from("ui/dist/index.html", "ui/dist/app.js")
    from("ui/dist/css") {
        into("css")
    }
    into("src/main/resources")
}

tasks.withType<org.springframework.boot.gradle.tasks.run.BootRun> {
    dependsOn("copyUi")
}


```


run 

```bash
./gradlew bootRun
```



Link - (https://drive.google.com/file/d/1UgxeJYCx5O4xgS23WR6oXAnCMyNnI7lB/view?usp=sharing)


Link - (https://drive.google.com/file/d/1d2h0mwMRALZVWjcteum7ds4MdOD63fZc/view?usp=sharing)
