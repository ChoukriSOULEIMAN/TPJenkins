pipeline {
    agent any
    environment {
        SUM_PY_PATH = '/app/sum.py'        
        DIR_PATH = '.' 
        TEST_FILE_PATH = 'teste_variables.txt'
        CONTAINER_NAME = 'python-container'
        IMAGE_NAME = 'python-sum-app'
        DOCKER_USERNAME = 'choukri34'       
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
    stage('Run') {
            steps {
                echo 'Exécution du conteneur Docker...'
                script {
                    def output = sh(script: 'docker run -d python-sum-app', returnStdout: true)
                    CONTAINER_ID = output.trim()
                    echo "Conteneur démarré avec ID : ${CONTAINER_ID}"
                }
            }
    stage('Test') {
            steps {
                echo 'Lancement des tests...'
                script {
                    def testLines = readFile(TEST_FILE_PATH).split('\n')
                    for (line in testLines) {
                        def vars = line.split(' ')
                        def arg1 = vars[0]
                        def arg2 = vars[1]
                        def expectedSum = vars[2].toFloat()

                        def output = sh(script: "docker exec ${CONTAINER_ID} python /app/sum.py ${arg1} ${arg2}", returnStdout: true).trim()
                        def result = output.toFloat()

                        if (result == expectedSum) {
                            echo "Test réussi : ${arg1} + ${arg2} = ${result}"
                        } else {
                            error "Test échoué : ${arg1} + ${arg2} != ${expectedSum}, obtenu ${result}"
                        }
                    }
                }
            }
        }
    }
    post {
        always {
            echo 'Nettoyage...'
            sh "docker stop ${CONTAINER_ID}"
            sh "docker rm ${CONTAINER_ID}"
        }
    }
    stage('Deploy') {
            steps {
                echo 'Déploiement sur DockerHub...'
                script {
                    sh 'docker login -u <votre_utilisateur> -p <votre_mot_de_passe>'
                    sh 'docker tag python-sum-app <votre_utilisateur>/python-sum-app:latest'
                    sh 'docker push <votre_utilisateur>/python-sum-app:latest'
                }
            }
        }
}    