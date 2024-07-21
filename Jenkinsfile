pipeline {
    agent any
    
    environment {
		DOCKERHUB_CREDENTIALS=credentials('ludivine-Dockerhub')
	}

    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
        disableConcurrentBuilds()
        timeout (time: 60, unit: 'MINUTES')
        timestamps()
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
                sh 'mvn clean compile'  // Compile and package the application
            }
        }
        
        stage('SonarQube analysis') {
            agent {
                docker {
                  image 'sonarsource/sonar-scanner-cli:4.7.0'
                }
            }
               environment {
                   CI = 'true'
                //    scannerHome = tool 'Sonarqube'
                   scannerHome='/opt/sonar-scanner'
                }
            steps{
                withSonarQubeEnv('sonarqube') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }     
        
        // stage('Test') {
        //     steps {
        //         echo 'Testing...'
        //         sh 'mvn test'
        //     }
        // }

        stage('Deploy') {
            steps {
                echo 'Deploying...'
                // Add your deploy steps here
            }
        }
    }
}
