pipeline {
    agent any

    stages {
        
        stage('Checkout') {
            steps {
              git branch: 'features', credentialsId: 'jenkins-master-ludi-multi', url: 'git@github.com:READY-TO-DEVOPS-JOBS/ludi-multi-project.git'  
            }
        }
        
        stage('Compile') {
            steps {
                echo 'Compiling...'
                // Compile the Java code
                sh 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                echo 'Testing...'
                // Run tests
                sh 'mvn test'
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

    post {
        always {
            // Archive test results and build artifacts
            junit '**/target/surefire-reports/*.xml'
            archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
        }
    }
}
