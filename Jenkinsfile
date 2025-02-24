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
                        withSonarQubeEnv('sonar-token') {
                            sh 'mvn clean verify sonar:sonar -Dsonar.projectKey=java_web_app'
                        }
                    }
                }
            }
        }
    }
}
