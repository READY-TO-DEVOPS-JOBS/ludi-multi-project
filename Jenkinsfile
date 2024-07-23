pipeline {
    agent any

    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
        disableConcurrentBuilds()
        timeout (time: 60, unit: 'MINUTES')
        timestamps()
    }

    environment {
        MAVEN_VERSION = '3.8.5'
        MAVEN_HOME = "${WORKSPACE}/maven"
        PATH = "${MAVEN_HOME}/bin:${env.PATH}"
    }

    stages {
        stage('Install Maven') {
            steps {
                sh '''
                wget https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
                tar xzvf apache-maven-${MAVEN_VERSION}-bin.tar.gz
                mv apache-maven-${MAVEN_VERSION} ${MAVEN_HOME}
                '''
            }
        }

        stage('Checkout') {
            steps {
               git branch: 'features', credentialsId: 'token-jenkins-git', url: 'https://github.com/READY-TO-DEVOPS-JOBS/ludi-multi-project.git'
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

        stage('Deploy') {
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
