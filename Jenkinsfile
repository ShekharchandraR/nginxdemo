pipeline {
    agent any 

    environment {
        IMAGE_NAME = 'nginxdemo' // Your custom Nginx image name
        CONTAINER_NAME = 'nginx_container' // Name for your running container
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout your code containing the Dockerfile
                checkout scm
            }
        }

	stage('SonarQube Code Analysis') {
            steps {
                dir("${WORKSPACE}"){
                // Run SonarQube analysis for Python
                script {
                    def scannerHome = tool name: 'scanner-name', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
                    withSonarQubeEnv('sonar') {
                        sh "echo $pwd"
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
            }
       }
       stage("SonarQube Quality Gate Check") {
            steps {
                script {
                def qualityGate = waitForQualityGate()
                    
                    if (qualityGate.status != 'OK') {
                        echo "${qualityGate.status}"
                        error "Quality Gate failed: ${qualityGateStatus}"
                    }
                    else {
                        echo "${qualityGate.status}"
                        echo "SonarQube Quality Gates Passed"
                    }
                }
            }
        }


        stage('Build Custom Nginx Docker Image') {
            steps {
                script {
                    // Build the Docker image from the Dockerfile
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Stop and Remove Existing Container') {
            steps {
                script {
                    // Stop and remove the existing container if it exists
                    sh """
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                    """
                }
            }
        }

        stage('Run New Nginx Container') {
            steps {
                script {
                    // Run the new Nginx container
                    sh "docker run --name ${CONTAINER_NAME} -d -p 8000:80 ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        always {
            script {
                // Optionally remove the image after running
                sh "docker rmi ${IMAGE_NAME} || true"
            }
        }
    }
}
