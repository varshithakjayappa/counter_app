pipeline {
    agent any
    environment {
        SONARQUBE_ENV = credentials('sonar-token')
    }
    stages {
        stage("gitcheckout") {
            steps {
                script {
                    git branch: 'main', url: 'https://github.com/varshithakjayappa/counter_app.git'
                }
            }
        }
        stage("sonarquality status") {
            steps {
                script {
                    docker.image('maven:latest').inside {
                        withSonarQubeEnv('sonar-server') {
                            sh 'mvn clean verify sonar:sonar -Dsonar.projectKey=counter_app'
                        }
                    }
                }
            }
        }
        stage("quality gate check"){
            steps{
                script{
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token'
                }
            }
        }
    }
}
