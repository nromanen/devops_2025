import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
  	id("org.springframework.boot") version "3.1.0"
  	id("io.spring.dependency-management") version "1.1.0"
  	kotlin("jvm") version "1.8.21"
  	kotlin("plugin.spring") version "1.8.21"
	kotlin("plugin.serialization") version "1.8.21"
}

group = "academy.softserve"
version = "0.0.1-SNAPSHOT"
java {
	sourceCompatibility = JavaVersion.VERSION_17
}

repositories {
	mavenCentral()
}

dependencies {
	implementation("org.springframework.boot:spring-boot-starter-webflux")
	implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.5.1")
	implementation("io.projectreactor.kotlin:reactor-kotlin-extensions")
	implementation("org.jetbrains.kotlin:kotlin-reflect")
	implementation("org.jetbrains.kotlinx:kotlinx-coroutines-reactor")
}

tasks.withType<KotlinCompile> {
	kotlinOptions {
		freeCompilerArgs += "-Xjsr305=strict"
		jvmTarget = "17"
	}
}


// TODO: your code starts herea
//
//
//

val npmInstall = tasks.register<Exec>("npmInstall") {
    workingDir = file("ui")
    commandLine("npm", "i")
}

val compileUi = tasks.register<Exec>("compileUi") {
    workingDir = file("ui")
    commandLine("npm", "run", "build")
    dependsOn(npmInstall)
}



val copyUi = tasks.register<Copy>("copyUi") {
    dependsOn(compileUi)
    from("ui/dist/index.html", "ui/dist/app.js")
    from("ui/dist/css") {
        into("css")
    }
    into("src/main/resources")


}



tasks.withType<org.springframework.boot.gradle.tasks.run.BootRun> {
    dependsOn(copyUi)
}
