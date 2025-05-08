pipeline {
    agent any

    environment {
        NODE_VERSION = '22.0.0'  // specify exact version
        NODE_DIR = "${env.WORKSPACE}/.node"
        PATH = "${env.WORKSPACE}/.node/bin:${env.PATH}"
    }

    stages {
        stage('Prepare') {
            steps {
                echo "Installing Node.js v${NODE_VERSION} locally..."
                sh '''
                  mkdir -p $NODE_DIR
                  curl -o node.tar.xz https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz
                  tar -xf node.tar.xz
                  mv node-v$NODE_VERSION-linux-x64/* $NODE_DIR
                '''
                sh 'node -v'
                sh 'npm -v'
            }
        }

        stage('Build') {
            steps {
                echo "Simulating build with local npm..."
                sh 'npm -v'
            }
        }

        stage('Test') {
            steps {
                echo "JENKINS_URL environment test..."
                sh 'echo $JENKINS_URL'
            }
        }
    }
}
