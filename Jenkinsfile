pipeline {
    agent none

    environment {
        PROJECT_NAME = 'ci-jenkins-agent'
        DOCKER_REGISTRY = credentials('HOST_DOCKER_REGISTRY')
    }

    stages {
        stage('Build aarch64') {
            agent { 
                label 'aarch64'
            }
            steps {
                echo 'Building...'
                
                sh "docker build --tag \044DOCKER_REGISTRY/$PROJECT_NAME:arm64-${getVersion()} ."
            }
        }
        stage('Build amd64') {
            agent { 
                label 'amd64'
            }
            steps {
                echo 'Building...'
                
                sh "docker build --tag \044DOCKER_REGISTRY/$PROJECT_NAME:amd64-${getVersion()} ."
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
                
                sh "docker push \044DOCKER_REGISTRY/$PROJECT_NAME:amd64-${getVersion()}"
                
                sh "docker manifest create --insecure --amend \044DOCKER_REGISTRY/$PROJECT_NAME:${getVersion()} \044DOCKER_REGISTRY/$PROJECT_NAME:amd64-${getVersion()} \044DOCKER_REGISTRY/$PROJECT_NAME:arm64-${getVersion()}"
                sh "docker manifest create --insecure --amend \044DOCKER_REGISTRY/$PROJECT_NAME:latest \044DOCKER_REGISTRY/$PROJECT_NAME:amd64-${getVersion()} \044DOCKER_REGISTRY/$PROJECT_NAME:arm64-${getVersion()}"
                
                sh "docker manifest push --insecure --purge \044DOCKER_REGISTRY/$PROJECT_NAME:${getVersion()}"
                sh "docker manifest push --insecure --purge \044DOCKER_REGISTRY/$PROJECT_NAME:latest"
            }
        }
        stage('Clean aarch64') {
            agent { 
                label 'aarch64'
            }
            steps {
                echo 'Cleaning...'

                sh "docker rmi \044DOCKER_REGISTRY/$PROJECT_NAME:arm64-${getVersion()}"
            }
        }
        stage('Clean amd64') {
            agent { 
                label 'amd64'
            }
            steps {
                echo 'Cleaning...'

                sh "docker rmi \044DOCKER_REGISTRY/$PROJECT_NAME:amd64-${getVersion()}"
            }
        }
    }
}

def getVersion() {
    return "${env.TAG_NAME ? env.TAG_NAME.substring(1) : 'SNAPSHOT.' + env.BUILD_NUMBER}";
}
