pipeline {
    agent any 
    environment {
        CONTAINER_ID = ''
        SUM_PY_PATH = 'sum.py' // Chemin vers sum.py dans le conteneur
        DIR_PATH = '.' // Répertoire contenant le Dockerfile
        TEST_FILE_PATH = 'teste_variables.txt' // Chemin vers votre fichier de test (à créer)
    }
    stages {
        stage('Build') {
            steps {
                script {
                    sh "docker build -t python-sum-app ${DIR_PATH}"
                }
            }
        }
        stage('Run') {
            steps {
                script {
                    def output = sh(script: "docker run -d python-sum-app", returnStdout: true)
                    CONTAINER_ID = output.trim()
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    // Lire les lignes du fichier test_variables.txt et exécuter les tests ici.
                }
            }
        }
    }
    post {
        always {
            script {
                sh "docker stop ${CONTAINER_ID}"
                sh "docker rm ${CONTAINER_ID}"
            }
        }
    }
}