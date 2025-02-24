pipeline{
    agent any
      environment {
        SONARQUBE_ENV = credentials('sonar-token') // SonarQube credentials ID 
    }
    stages{
        stage("gitcheckout"){
            steps{
               script{
                 git branch: 'main', url: 'https://github.com/varshithakjayappa/counter_app.git'
                }
            }
        }

        stage("sonarquality status"){
            agent {
                docker {
                    image 'maven:latest'
                }
            } 
            steps{
                script {
                  withSonarQubeEnv('sonar-token') {
                    sh 'mvn clean verify sonar:sonar -Dsonar.projectKey=java_web_app'
                 }
                }
            }
            
        }
    }
}