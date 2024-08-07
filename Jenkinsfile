pipeline {
    agent any 

    environment {
        IMAGE_NAME = 'nginx:latest' // Specify the Nginx image
        CONTAINER_NAME = 'nginx_container' // Name for your container
        DOCKER_CREDENTIALS_ID = 'your-docker-credentials-id' // Your Docker credentials ID (if needed)
    }

    stages {
        stage('Pull Latest Nginx Image') {
            steps {
                script {
                    // Pull the latest Nginx image
                    sh "docker pull ${IMAGE_NAME}"
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
                    sh "docker run --name ${CONTAINER_NAME} -d -p 80:80 ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        always {
            script {
                // Cleanup: Optionally remove the image
                sh "docker rmi ${IMAGE_NAME} || true"
            }
        }
    }
}
