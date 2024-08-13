pipeline {
    agent any

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
            steps {
                git branch: 'main', url: 'https://github.com/READY-TO-DEVOPS-JOBS/ludi-multi-project.git'
            }
        }

        stage('Login to DockerHub') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Compile') {
            agent {
                docker {
                    image 'maven:3.8.5-openjdk-17'
                    args '-v $HOME/.m2:/root/.m2' // Caches Maven dependencies between builds
                }
            }
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'maven:3.8.5-openjdk-17'
                    args '-v $HOME/.m2:/root/.m2' // Caches Maven dependencies between builds
                }
            }
            steps {
                echo 'Running tests...'
                sh 'mvn test -DskipTests=true'  // Tests are skipped here
            }
        }

        stage('SonarQube Analysis') {
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

        stage('Package') {
            agent {
                docker {
                    image 'maven:3.8.5-openjdk-17'
                }
            }
            steps {
                sh 'mvn clean package -DskipTests=true'
                stash includes: 'target/*.jar', name: 'jar'
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                unstash 'jar'
                script {
                    def imageName = "devopseasylearning/s5ludivine:javaapp-$BUILD_NUMBER"
                    
                    // Ensure the artifact exists
                    sh 'ls -l target/*.jar'

                    // Build Docker image
                    sh """
                    docker build -t $imageName .
                    docker push $imageName
                    """
                }
            }
        }
    }
}






   
    // stage('File System Scan') {
        //     steps {
        //         sh "trivy fs --format table -o trivy-fs-report.html ."
        //     }
        // }

    // stage('Docker Image Scan') {
    //         steps {
    //             sh "trivy image --format table -o trivy-image-report.html fridade/comm-card:jenkins-$BUILD_NUMBER "
    //         }
    //     }


//  stage('helm-charts') {


// 	      steps {
// 	        script {
// 	          withCredentials([
// 	            string(credentialsId: 'github-cred', variable: 'TOKEN')
// 	          ]) {

// 	            sh '''
//                 rm -rf commercial-card || true 
//                 git clone https://$TOKEN@github.com/fridade/commercial-card.git
//                 cd commercial-card
// cat << EOF > values.yaml
//        repository:
//          tag:   jenkins-$BUILD_NUMBER
//          assets:
//           image: fridade/comm-card
       
         
// EOF
// git config --global user.name "fridade"
// git config --global user.email "info@fridade.com"
//    cat  values.yaml
   
//    git add -A 
//     git commit -m "Change from JENKINS" 
//     git push  https://fridade:$TOKEN@github.com/fridade/commercial-card.git
// 	            '''
// 	          }

// 	        }

// 	      }

// 	    }


      




       
        





   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
//    }




