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
        stage('Deploy amd64') {
            agent { 
                label 'amd64'
            }
            when {
                tag "*"
            }
            steps {
                echo 'Deploying...'
                
                sh "docker push \044DOCKER_REGISTRY/$PROJECT_NAME:${getVersion()}"
                sh "docker push \044DOCKER_REGISTRY/$PROJECT_NAME:latest"
            }
        }
        stage('Clean amd64') {
            agent { 
                label 'amd64'
            }
            steps {
                echo 'Cleaning...'

                sh "docker rmi \044DOCKER_REGISTRY/$PROJECT_NAME:${getVersion()}"
                sh "docker rmi \044DOCKER_REGISTRY/$PROJECT_NAME:latest"
            }
        }


        stage('Build aarch64') {
            agent { 
                label 'aarch64'
            }
            steps {
                echo 'Building...'
                
                sh "docker build --tag \044DOCKER_REGISTRY/$PROJECT_NAME:arm64-${getVersion()} ."
                sh "docker tag \044DOCKER_REGISTRY/$PROJECT_NAME:arm64-${getVersion()} \044DOCKER_REGISTRY/$PROJECT_NAME:arm64-latest"
            }
        }
        
        stage('Deploy aarch64') {
            agent { 
                label 'aarch64'
            }
            when {
                tag "*"
            }
            steps {
                echo 'Deploying...'
                
                sh "docker push \044DOCKER_REGISTRY/$PROJECT_NAME:arm64-${getVersion()}"
                sh "docker push \044DOCKER_REGISTRY/$PROJECT_NAME:arm64-latest"
            }
        }
        stage('Clean aarch64') {
            agent { 
                label 'aarch64'
            }
            steps {
                echo 'Cleaning...'

                sh "docker rmi \044DOCKER_REGISTRY/$PROJECT_NAME:arm64-${getVersion()}"
                sh "docker rmi \044DOCKER_REGISTRY/$PROJECT_NAME:arm64-latest"
            }
        }
    }
}

def getVersion() {
    return "${env.TAG_NAME ? env.TAG_NAME.substring(1) : 'SNAPSHOT.' + env.BUILD_NUMBER}";
}
