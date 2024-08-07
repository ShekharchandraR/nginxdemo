pipeline {
    agent any 

    environment {
        // Define any necessary environment variables
        IMAGE_NAME = 'nginxdemo'
        CONTAINER_NAME = 'nginxdemo'
	DOCKER_ps = 'docker ps'
	DOCKER_PS_A = 'docker ps -a'
	DOCKER_IMAGE = 'docker images'
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
                sh "docker stop $( DOCKER_PS  ) || true"
                sh "docker rm $( DOCKER_PS_A ) || true"
                // Optionally remove the image
                sh "docker stop $( DOCKER_IMAGES ) || true"
            }
        }
    }
}
