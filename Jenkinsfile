pipeline { 
    agent any

    environment {
        CONTAINER_ID = ''
        SUM_PY_PATH = '/app/sum.py'
        TEST_FILE_PATH = "${WORKSPACE}\\teste_variables.txt"
    }

    stages {
        stage('Build') {
            steps {
                script {
                    // Construction de l'image Docker
                    sh 'docker build -t python-sum-app .'
                }
            }
        }
        stage('Run') {
            steps {
                script {
                    // Lancer le conteneur en arrière-plan
                    def output = sh(script: 'docker run -d python-sum-app', returnStdout: true).trim()
                    CONTAINER_ID = output
                }
            }
        }
        stage('Check Test File') {
            steps {
                script {
                    // Vérifier si le fichier de test existe
                    def fileExists = fileExists(TEST_FILE_PATH)
                    if (!fileExists) {
                        error "Le fichier ${TEST_FILE_PATH} est introuvable."
                    }
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    // Lecture du fichier de test et exécution des tests
                    def testLines = readFile(TEST_FILE_PATH).split('\n')
                    for (line in testLines) {
                        def vars = line.split(' ')
                        def arg1 = vars[0]
                        def arg2 = vars[1]
                        def expectedSum = vars[2].toFloat()
                        def output = sh(script: "docker exec ${CONTAINER_ID} python ${SUM_PY_PATH} ${arg1} ${arg2}", returnStdout: true).trim()
                        def result = output.toFloat()
                        if (result == expectedSum) {
                            echo "Test réussi : ${arg1} + ${arg2} = ${expectedSum}"
                        } else {
                            error "Test échoué : ${arg1} + ${arg2} != ${expectedSum}"
                        }
                    }
                }
            }
        }
    }

    post {
        always {
            // Arrêter et supprimer le conteneur Docker
            sh "docker stop ${CONTAINER_ID}"
            sh "docker rm ${CONTAINER_ID}"
        }
    }
}
