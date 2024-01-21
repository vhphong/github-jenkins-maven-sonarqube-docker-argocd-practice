pipeline {
    agent any
    tools {
        maven 'maven_3_8_8'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'github_credentials', url: 'https://github.com/vhphong/github-jenkins-maven-sonarqube-docker-argocd-practice']])
                bat 'mvn clean install'
            }
        }

        stage('Build and Test') {
            steps {
                bat 'dir -ltr'
                // build the project and create a JAR file
                bat 'cd ./github-jenkins-maven-sonarqube-docker-argocd-practice && mvn clean package'
            }
        }

        stage('Build Docker image') {
            steps {
                script {
                    bat 'docker build -t phongvo0222/github-jenkins-maven-sonarqube-docker-argocd .'
                }
            }
        }

        stage('Push image to DockerHub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                        bat "docker login -u phongvo0222 -p ${dockerhubpwd}"    // double quotes for retrieving variable
                    }
                    bat 'docker push phongvo0222/github-jenkins-maven-sonarqube-docker-argocd'
                }
            }
        }
    }
}
