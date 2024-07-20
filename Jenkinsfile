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
                sh 'mvn clean package'  // Compile and package the application
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'maven:3.6.3-jdk-11'
                    args '-v /var/run/docker.sock:/var/run/docker.sock'  // Optional: if you need Docker inside Docker
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
