pipeline {
    agent {
        label 'SERVER03'
    }
    environment {
        DOCKERHUB_CREDENTIALS = credentials('del-docker-hub-auth')
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
        disableConcurrentBuilds()
        timeout(time: 60, unit: 'MINUTES')
        timestamps()
    }

    stages {
        stage('Checkout') {
            agent {
                label 'SERVER03'
            }
            steps {
                git branch: 'features', credentialsId: 'token-jenkins-git', url: 'https://github.com/READY-TO-DEVOPS-JOBS/ludi-multi-project.git'
                sh 'git branch'  // Verify the current branch
            }
        }

        stage('Compile and Package') {
            agent {
                docker {
                    image 'maven:3.8.5-openjdk-17'
                }
            }
            steps {
                echo 'Compiling and packaging...'
                sh 'mvn clean package -DskipTests=true'  // Compile and package the source code, skipping tests
                sh 'ls -la target'  // List the contents of the target directory for debugging
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
                sh 'mvn clean'
                sh 'mvn test -DskipTests=true' 
                 // Run tests, but skip them
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

        stage('Build and Push Docker Image') {
            agent {
                label 'SERVER03'
            }
            steps {
                script {
                    def imageName = 'devopseasylearning/s5ludivine:project-shack'
                    sh "docker build -t $imageName ."
                    sh "docker push $imageName"
                }
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