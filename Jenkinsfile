pipeline {
    agent any
    stages {
        stage('Build Image') {
            steps {
                sh 'docker build -t niloyroy0000/todo-app:latest .'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) {
                    sh "echo \$DOCKER_HUB_PASSWORD | docker login -u \$DOCKER_HUB_USERNAME --password-stdin"
                    sh "docker push niloyroy0000/todo-app:latest"
                }
            }
        }
    }
}
