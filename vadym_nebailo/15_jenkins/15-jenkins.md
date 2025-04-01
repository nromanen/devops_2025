#### 1. Jenkinsfile
```
pipeline {
    agent any

    stages {
        stage('Prepare') {
            steps {
                sh 'curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -'
                sh 'sudo apt install -y nodejs'
            }
        }

        stage('Build') {
            steps {
                script {
                    sh 'npm --version'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    echo "JENKINS_URL is: ${env.JENKINS_URL}"
                }
            }
        }
    }
}
```

#### 2. Link to Git repository with Jenkinsfile
 - https://github.com/vadimN/jenkins-sanbox

#### 3. Screenshots
1. [Create Jenkins Account](https://drive.google.com/file/d/1VrzqcBTD4Gyb7PkUQgXm3NR_HFy-I5ja/view?usp=sharing)
2. [Jenkins plugins installation](https://drive.google.com/file/d/1Wx1A2FlApw57rsnHn3dfBA8INO3lvfOI/view?usp=sharing)
3.  [Checkout SCM](https://drive.google.com/file/d/1yDNOauKMvpj4ncHKZv745vTun8SDiq5o/view?usp=sharing)
4. [Prepare](https://drive.google.com/file/d/1BZobU0VnCg7O2bR06ribggiKEpCKrQcW/view?usp=sharing)
5. [Build](https://drive.google.com/file/d/1Mqq_eJYxyTkPvTG9IwlC3z9BN5DB2_jt/view?usp=sharing)
6. [Test](https://drive.google.com/file/d/1GhDfkdC9YrhK0YruFzwBX6xDb6YAJ7jM/view?usp=sharing)