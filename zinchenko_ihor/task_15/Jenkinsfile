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
                sh 'npm -v'
            }
        }
        stage('Test') {
            steps {
                sh 'echo "JENKINS_URL: $JENKINS_URL"'
            }
        }
    }
}
