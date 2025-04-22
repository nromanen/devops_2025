# Task 15: Jenkins

> Done by [@Lians-coder](https://github.com/Lians-coder) (Kateryna Kravchuk)

---

## Install & configure Jenkins

### Task 1

Install Jenkins and necessary plugins and ensure Jenkins is operational and accessible for configuring pipelines.  

### Process 1.1: Installing

1. Install Java first because Jenkins is written in Java.  

```bash
sudo apt install -y fontconfig openjdk-17-jdk
```

To check the success: `java --version`.  
Output:  

```bash
openjdk 17.0.14 2025-01-21
OpenJDK Runtime Environment (build 17.0.14+7-Ubuntu-124.04)
OpenJDK 64-Bit Server VM (build 17.0.14+7-Ubuntu-124.04, mixed mode, sharing)
```

2. Install Jenkins' key.  

```bash
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
```

> The first line imports GPG key, which then will check up the integrity of a Jenkins package.  
> The next command adds a stable release of long-term support (LTS) to the source list.  

3. Install Jenkins: `sudo apt-get install -y jenkins`.  

4. Start Jenkins.  

```bash
sudo systemctl enable --now jenkins
sudo systemctl status jenkins
```

Output:  

```bash
● jenkins.service - Jenkins Continuous Integration Server
     Loaded: loaded (/usr/lib/systemd/system/jenkins.service; enabled; preset: enabled)
     Active: active (running) since Sun 2025-03-30 09:32:14 UTC; 1min 1s ago
   Main PID: 4425 (java)
      Tasks: 40 (limit: 2273)
     Memory: 400.4M (peak: 409.3M)
        CPU: 27.574s
     CGroup: /system.slice/jenkins.service
             └─4425 /usr/bin/java -Djava.awt.headless=true -jar /usr/share/java/jenkins.war --webroot=/var/cache/jenkins/war --httpPort=8080
```

### Process 1.2: Firewall

```bash
sudo ufw allow 8080
sudo ufw enable
sudo ufw status
```

Output:  

```bash
Firewall is active and enabled on system startup
Status: active

To                         Action      From
--                         ------      ----
8080                       ALLOW       Anywhere
8080 (v6)                  ALLOW       Anywhere (v6)
```

### Process 1.3: Configure

1. Navigate to the server from browser: `http://localhost:8080`.  

[Output page](https://drive.google.com/file/d/1lFWqERTOaAUdm07oaMkJ_Cib9GTpN1T-/view?usp=drive_link)  

2. Get an admin password: `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`. Unlock server by providing it in the corresponding field.  

3. Finalize the configuration process by:  
    - installing the nessessary [plugins](https://drive.google.com/file/d/1TEqqYf93q-9nWESn0H3CbSR6oyd1PVbH/view?usp=drive_link);  
    - creating the first [admin](https://drive.google.com/file/d/1NwuD9lKCBNVUsgfbv5_cPXhOKvMbGb_f/view?usp=drive_link);  
    - [instance](https://drive.google.com/file/d/1ND7kmcfE78uEAQlBiLz8XRXzAskvKmWY/view?usp=drive_link) configuration.  

---

## Jenkinsfile

### Task 2

Develop a *Jenkinsfile* that outlines a basic CI/CD pipeline structure with the following stages:  
    1. **Prepare**: Include a stage that installs Node.js version 22.  
    2. **Build**: Simulate the build process by showing the version of npm.  
    3. **Test**: Simulate the testing process by displaying the environment variable JENKINS_URL.

### 2.1 Jenkinsfile

```groovy
pipeline {
    agent any
    
    environment {
        NODE_VERSION = '22'
    }

    stages {
        stage('Install Node.js') {
            steps {
                script {
                    echo "Preparation ..."                
                    echo "Downloading Node.js & npm ..."
                    sh "curl -fsSL https://deb.nodesource.com/setup_${env.NODE_VERSION}.x | sudo -E bash -"
                    echo "Installing Node.js & npm ..."
                    sh "sudo apt-get install -y nodejs"
                }                
            }
        }
        stage('Build') {
            steps {
                echo "Building ..."
                sh "echo NPM:"
                sh "npm -v"
            }
        }
        stage('Test') {
            steps {
                echo "Testing ..."
                echo "Jenkins URL: ${env.JENKINS_URL}"
            }
        }
    }
}
```

### Task 2.2

Once the Jenkinsfile is created, upload it to your GitHub repository.  

### Result 2.2

[Jenkinsfile](https://github.com/Lians-coder/git_task/blob/main/Jenkinsfile) in the repo, where everything have been tested and verified.  

### Task 3.2

Configure Jenkins to run the pipeline by retrieving the Jenkinsfile from your GitHub repository.  

#### Webhook configuration (optional)

To use **webhooks**, first get a *white* IP, for example, from [ngrok](https://ngrok.com/).  

```bash
curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok
```

Add the obtained token to the *.yml* file:  

```bash
ngrok config add-authtoken <secret-value>
```

Output:  

```bash
Authtoken saved to configuration file: /home/vagrant/.config/ngrok/ngrok.yml
```

Navigate to the server by this new address:  

```bash
ngrok http --url=<new-address>.app 8080
```

[Output](https://drive.google.com/file/d/14SGKR8BL29RjhzXaohZwFaqiXjhuRm0e/view?usp=drive_link)

##### GitHub settings

1. GitHub repo settings -> Webhooks -> Add Webhook.  
2.1 Set *Payload URL* to: `http://<new-address>.app`.  
2.2 Set *Content Type* to `application/json`.  
2.3 Choose *Just the push event*.  
3. `Add Webhook`.  

##### Jenkins configuration

1. Add this after *environment* configurations in the *Jenkinsfile*:  

```groovy
triggers {
    githubPush()
}
```

2. When configuring a job, select `GitHub hook trigger for GITScm polling`.  

### Process 3.2

1. Configure *new item* from the Dashboard by selecting *Pipeline*.  
In the *Definition* section choose `Pipeline script from SCM`, then for *SCM* choose `Git`, then provide a **repository URL** in the corresponding field below.  

2. Add this to the *Jenkinsfile* as the first stage:  

```groovy
stage('Checkout') {
    steps {
        script {
            node {
                checkout scm
            }
        }
    }
}
```

### Run

1. First, enable *Jenkins* to run in *sudo* mode: `sudo visudo`, then add the following to the file:  

```bash
jenkins ALL=(ALL) NOPASSWD: ALL
```

Restart service to apply changes: `sudo systemctl restart jenkins`.  

2. **Build now** a pipeline from the server and wait for the output.  

[Output](https://drive.google.com/file/d/1VAHEYDmzSKvtnuCaijwAJnI-YqhZQYR7/view?usp=drive_link)  
[Console output](https://github.com/Lians-coder/git_task/blob/main/console.log)  

---

## Results

[Repository](https://github.com/Lians-coder/git_task.git) with the [Jenkinsfile](https://github.com/Lians-coder/git_task/blob/main/Jenkinsfile).
[**All screenshots**](https://drive.google.com/drive/folders/1RyGAmecowiPPuGeLN9wOr_zGEtnKcQBN?usp=drive_link) taken during pipeline execution.  
Crucial outputs:  
    - [Prepare](https://drive.google.com/file/d/14BJOutoU_hZHbI7Cdp5we-u9ojpRZ7zb/view?usp=drive_link),  
    - [Build](https://drive.google.com/file/d/1UMSdiT4ElXu4RnVmbR-tNd5DIHrdjTOT/view?usp=drive_link),  
    - [Test](https://drive.google.com/file/d/1lmyYzsG_bSF1kixz00VdRvxbIVy7CHrm/view?usp=drive_link).  
