pipeline {
    agent any

    stages {
        
        stage('checkout') {
            steps {
              git branch: 'features', credentialsId: 'jenkins-master-ludi-multi', url: 'git@github.com:READY-TO-DEVOPS-JOBS/ludi-multi-project.git'  
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                // Add your test steps here
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                // Add your deploy steps here
            }
        }
        stage('Deploy2') {
            steps {
                echo 'Deploying...'
                // Add your deploy steps here
            }
        }


    }
}

