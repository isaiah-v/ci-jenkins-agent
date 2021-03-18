pipeline {
    agent none

    environment {
        PROJECT_NAME = 'ci-jenkins-agent'
        DOCKER_REGISTRY = credentials('HOST_DOCKER_REGISTRY')
    }

    stages {
        stage('Build amd64') {
            agent { 
                label 'amd64'
            }
            steps {
                echo 'Building...'
                
                sh "docker build --tag \044DOCKER_REGISTRY/$PROJECT_NAME:${getVersion()} ."
                sh "docker tag \044DOCKER_REGISTRY/$PROJECT_NAME:${getVersion()} \044DOCKER_REGISTRY/$PROJECT_NAME:latest"
            }
        }
        stage('Build aarch64') {
            agent { 
                label 'aarch64'
            }
            steps {
                echo 'Building...'
                
                sh "docker build --tag \044DOCKER_REGISTRY/$PROJECT_NAME:${getVersion()} ."
                sh "docker tag \044DOCKER_REGISTRY/$PROJECT_NAME:${getVersion()} \044DOCKER_REGISTRY/$PROJECT_NAME:latest"
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
            }
        }
        stage('Deploy') {
            when {
                tag "*"
            }
            steps {
                echo 'Deploying...'
                
                sh "docker push \044DOCKER_REGISTRY/$PROJECT_NAME:${getVersion()}"
                sh "docker push \044DOCKER_REGISTRY/$PROJECT_NAME:latest"
            }
        }
        stage('Clean') {
            steps {
                echo 'Cleaning...'

                sh "docker rmi \044DOCKER_REGISTRY/$PROJECT_NAME:${getVersion()}"
                sh "docker rmi \044DOCKER_REGISTRY/$PROJECT_NAME:latest"
            }
        }
    }
}

def getVersion() {
    return "${env.TAG_NAME ? env.TAG_NAME : 'SNAPSHOT.' + env.BUILD_NUMBER}";
}
