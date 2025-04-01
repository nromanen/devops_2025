plugins {
    id("org.springframework.boot") version "3.2.3"
    id("io.spring.dependency-management") version "1.1.4"
    id("java")
}

group = "com.example"
version = "0.0.1-SNAPSHOT"
java.sourceCompatibility = JavaVersion.VERSION_17

repositories {
    mavenCentral()
}

dependencies {
    implementation("org.springframework.boot:spring-boot-starter")
    implementation("org.springframework.boot:spring-boot-starter-web")
}

tasks.register<Exec>("npmInstall") {
    workingDir = file("ui")
    commandLine = listOf("/usr/bin/npm", "i")
}

tasks.register<Exec>("compileUi") {
    dependsOn("npmInstall")
    workingDir = file("ui")
    commandLine = listOf("/usr/bin/npm", "run", "build")
}

tasks.register<Copy>("copyUi") {
    dependsOn("compileUi")
    from("ui/dist") {
        include("index.html")
        include("app.js")
        include("css/**")
    }
    into("src/main/resources")
}

tasks.withType<org.springframework.boot.gradle.tasks.run.BootRun> {
    dependsOn("copyUi")
}

tasks.withType<JavaExec> {
    mainClass.set("com.example.demo.DemoApplication")
}

tasks.named("processResources") {
    dependsOn("copyUi")
}
