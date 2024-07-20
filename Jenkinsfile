pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'features', credentialsId: 'jenkins-master-ludi-multi', url: 'git@github.com:READY-TO-DEVOPS-JOBS/ludi-multi-project.git'
                sh 'git branch'  // Verify the current branch
            }
        }
        
        stage('Compile') {
            steps {
                echo 'Compiling...'
                sh 'mvn clean compile'  // Compile and package the application
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'maven:3.6.3-jdk-11'
                }
            }
            steps {
                echo 'Testing...'
                sh 'mvn test'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying...'
                // Add your deploy steps here
            }
        }
    }
}
