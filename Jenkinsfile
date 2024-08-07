pipeline {
    agent any 

    environment {
        // Define any necessary environment variables
        IMAGE_NAME = 'nginxdemo'
        CONTAINER_NAME = 'nginxdemocont'
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout your code from the repository
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build(IMAGE_NAME)
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container
                    docker.run(IMAGE_NAME, CONTAINER_NAME, '-d')
                }
            }
        }
    }

    post {
        always {
            // Clean up the Docker containers and images
            script {
                // Stop and remove the container
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"
                // Optionally remove the image
                sh "docker rmi ${IMAGE_NAME} || true"
            }
        }
    }
}
