pipeline {
    agent none

    environment {
        PROJECT_NAME = 'ci-jenkins-agent'
        DOCKER_REGISTRY = credentials('HOST_DOCKER_REGISTRY')
    }

    stages {
        stage('Build Arm64') {
            agent { 
                label 'arm64'
            }
            steps {
                echo 'Building...'
                
                sh "docker build --tag \044DOCKER_REGISTRY/$PROJECT_NAME:arm64-${getVersion()} ."
            }
        }
        stage('Deploy Arm64') {
            agent { 
                label 'arm64'
            }
            when {
                tag "*"
            }
            steps {
                echo 'Deploying...'
                
                sh "docker push \044DOCKER_REGISTRY/$PROJECT_NAME:arm64-${getVersion()}"
            }
        }
        stage('Clean Arm64') {
            agent { 
                label 'arm64'
            }
            steps {
                echo 'Cleaning...'

                sh "docker rmi \044DOCKER_REGISTRY/$PROJECT_NAME:arm64-${getVersion()}"
            }
        }
        stage('Build Amd64') {
            agent { 
                label 'amd64'
            }
            steps {
                echo 'Building...'
                
                sh "docker build --tag \044DOCKER_REGISTRY/$PROJECT_NAME:amd64-${getVersion()} ."
            }
        }
        stage('Deploy Amd64') {
            agent { 
                label 'amd64'
            }
            when {
                tag "*"
            }
            steps {
                echo 'Deploying...'
                
                sh "docker push \044DOCKER_REGISTRY/$PROJECT_NAME:amd64-${getVersion()}"
            }
        }
        stage('Clean Amd64') {
            agent { 
                label 'amd64'
            }
            steps {
                echo 'Cleaning...'

                sh "docker rmi \044DOCKER_REGISTRY/$PROJECT_NAME:amd64-${getVersion()}"
            }
        }
        stage('Update Manifest') {
            agent { 
                label 'amd64'
            }
            when {
                tag "*"
            }
            steps {
                echo 'Updating...'
                
                sh "docker manifest create --insecure --amend \044DOCKER_REGISTRY/$PROJECT_NAME:${getVersion()} \044DOCKER_REGISTRY/$PROJECT_NAME:amd64-${getVersion()} \044DOCKER_REGISTRY/$PROJECT_NAME:arm64-${getVersion()}"
                sh "docker manifest create --insecure --amend \044DOCKER_REGISTRY/$PROJECT_NAME:latest \044DOCKER_REGISTRY/$PROJECT_NAME:amd64-${getVersion()} \044DOCKER_REGISTRY/$PROJECT_NAME:arm64-${getVersion()}"
                
                sh "docker manifest push --insecure --purge \044DOCKER_REGISTRY/$PROJECT_NAME:${getVersion()}"
                sh "docker manifest push --insecure --purge \044DOCKER_REGISTRY/$PROJECT_NAME:latest"
            }
        }
    }
}

def getVersion() {
    return "${env.TAG_NAME ? env.TAG_NAME.substring(1) : 'SNAPSHOT.' + env.BUILD_NUMBER}";
}
