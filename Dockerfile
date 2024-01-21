FROM openjdk:17
EXPOSE 8080
ADD target/github-jenkins-maven-sonarqube-docker-argocd.jar github-jenkins-maven-sonarqube-docker-argocd.jar
ENTRYPOINT ["java","-jar","/github-jenkins-maven-sonarqube-docker-argocd.jar"]