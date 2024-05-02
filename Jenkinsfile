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
        stage('snyk_scan'){
          steps  {
            snykSecurity severity: 'medium', snykInstallation: 'snyk', snykTokenId: 'snyk', targetFile: 'pom.xml'
            }
        }
        stage('Build and Push Docker Image') {
            steps {
              withCredentials([usernamePassword(credentialsId: 'b43e86d5-83a0-483c-b4d8-ef0c6daa20c4', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {

                sh '''
                docker build -t abhidhingra/jenkins-ts:${VERSION}  .
                docker login -u $USERNAME -p $PASSWORD
                docker push abhidhingra/jenkins-ts:${VERSION}
                '''
              }
            }
        }
        stage('Deploy an application') {
            steps {
                kubernetesDeploy(configs: "manifest.yaml")
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
