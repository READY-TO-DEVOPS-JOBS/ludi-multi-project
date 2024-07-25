pipeline {
    agent any

    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
        disableConcurrentBuilds()
        timeout(time: 60, unit: 'MINUTES')
        timestamps()
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'features', credentialsId: 'token-jenkins-git', url: 'https://github.com/READY-TO-DEVOPS-JOBS/ludi-multi-project.git'
                sh 'git branch'  // Verify the current branch
            }
        }

        stage('Compile') {
            agent {
                docker {
                    image 'maven:3.8.5-openjdk-17'
                }
            }
            steps {
                echo 'Compiling...'
                sh 'mvn clean compile'  // Compile the source code
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'maven:3.8.5-openjdk-17'
                }
            }
            steps {
                echo 'Running tests...'
                sh 'mvn test'  // Run the unit tests
            }
        }

        stage('SonarQube analysis') {
            agent {
                docker {
                    image 'sonarsource/sonar-scanner-cli:5.0.1'
                }
            }
            environment {
                CI = 'true'
                scannerHome = '/opt/sonar-scanner'
            }
            steps {
                withSonarQubeEnv('Sonar') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }

        stage('Deploy1') {
            steps {
                echo 'Deploying...'
                // Add your deploy steps here
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }
        success {
            echo 'Build succeeded!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}
