pipeline {
    agent {
        label 'jenkinsnode'
    }
    environment {
        VERSION = '1.0'
    }
    stages {
        stage('Build') {
            steps {
                sh '/usr/share/maven/bin/mvn package'
            }
        }
        stage('Test') {
            steps {
                sh '/usr/share/maven/bin/mvn test'
            }
        }
        stage('Build and Push Docker Image') {
            steps {
              withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {

                sh '''
                docker build -t christianheimke/jenkins-ts:${VERSION}  .
                docker login -u $USERNAME -p $PASSWORD
                docker push christianheimke/jenkins-ts:${VERSION}
                '''
              }
            }

        }

        stage('Release') {
            steps {
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
            }
        }
  }
}
