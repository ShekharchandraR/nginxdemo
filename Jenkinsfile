pipeline {
    agent any
    stages {
        stage('Build Docker') {
            steps {
                echo "Build image"
		
                script {
                    def customImage = docker.build("my-image:${env.BUILD_ID}")
                    customImage.push()
                }
            }
        }
    }
}
