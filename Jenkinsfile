pipeline {
    agent any
    environment {
        SUM_PY_PATH = '/app/sum.py'        // Chemin correct dans le conteneur
        DIR_PATH = '.' 
        TEST_FILE_PATH = 'teste_variables.txt'
        CONTAINER_NAME = 'python-container'
        IMAGE_NAME = 'python-sum-app'
        DOCKER_USERNAME = 'choukri34'       // Docker Hub username
        DOCKER_PASSWORD = 'choukri34'
    }
    stages {
        stage('Build') {
            steps {
                script {
                    echo "Construction de l'image Docker"
                    bat "docker build -t ${IMAGE_NAME} ${DIR_PATH}"   
                }
            }
        }
    }
}