pipeline {
    agent {
        docker {
            image 'adoptopenjdk:11-jdk-hotspot'
            args '-v /var/run/docker.sock:/var/run/docker.sock'  // Optional: if you need Docker inside Docker
        }
    }

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
                sh 'mvn clean compile'
            }
        }

        stage('Push') {
            steps {
                echo 'Pushing...'
                sh 'git push origin features'  // Ensure correct branch is pushed
            }
        }

        stage('Test') {
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
