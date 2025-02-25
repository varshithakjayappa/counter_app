pipeline {
    agent any
    tools {
        maven "maven3"
        jdk "jdk11"
    }
    environment {
        SONARQUBE_ENV = credentials('sonar-token')
        VERSION = "${env.BUILD_ID}"
    }
    stages {
        stage("gitcheckout") {
            steps {
                script {
                    git branch: 'main', url: 'https://github.com/varshithakjayappa/counter_app.git'
                }
            }
        }
         stage('Compile') {
            steps {
                 sh "mvn compile"
            }
        }
        
        stage('Unit Tests') {
            steps {
                sh "mvn test -DskipTests=true"
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
       /* stage("quality gate check"){
            steps{
                script{
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token'
                }
            }
        }*/
         stage('Build') {
            steps {
               sh "mvn package -DskipTests=true"
            }
        }
        stage("docker build & docker push to Nexus repository"){
            steps{
                script{
                    withCredentials([string(credentialsId: 'nexus_password', variable: 'nexus_cred')]) {
                    sh '''
                    docker build -t 172.17.0.1:8085/springboot-app:${VERSION} .
                    docker login -u admin -p $nexus_cred 172.17.0.1:8085
                    docker push 172.17.0.1:8085/springboot-app:${VERSION}
                    docker rmi 172.17.0.1:8085/springboot-app:${VERSION}  
                    ''' 
                    }
                    
                }
            }
        }
    }
}
