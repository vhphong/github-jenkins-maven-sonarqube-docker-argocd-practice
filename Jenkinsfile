pipeline {
    agent any
    tools {
        maven 'maven_3_8_8'
    }
//     triggers {
//         pollSCM '* * * * *'
//     }

    stages {
        stage('Checkout') {
            steps {
                echo 'Doing Checkout..'
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'github_credentials', url: 'https://github.com/vhphong/github-jenkins-maven-sonarqube-docker-argocd-practice']])
            }
        }

        stage('Build and Test') {
            steps {
                echo 'Doing building and testing..'
                bat 'dir'
                // build the project and create a JAR file
                bat 'mvn clean install'
            }
        }

        stage('Static Code Analysis') {
            environment {
                SONAR_URL = 'http://localhost:9000'
            }
            steps {
                echo 'Doing static code analyzing..'
                withCredentials([string(credentialsId: 'sonarqube_id', variable: 'SONAR_AUTH_TOKEN')]) {
                    bat "mvn sonar:sonar -Dsonar.login=$SONAR_AUTH_TOKEN -Dsonar.host.url=${SONAR_URL}"
                // bat 'cd java-maven-sonar-argocd-helm-k8s/spring-boot-app && mvn sonar:sonar -Dsonar.login=$SONAR_AUTH_TOKEN -Dsonar.host.url=${SONAR_URL}'
                }
            }
        }

        stage('Build Docker image') {
            steps {
                echo 'Doing building a docker image..'
                script {
                    bat 'docker build -t phongvo0222/github-jenkins-maven-sonarqube-docker-argocd .'
                }
            }
        }

        stage('Push image to DockerHub') {
            steps {
                echo 'Doing pushing the image to DockerHub..'
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
