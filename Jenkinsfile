pipeline {
    agent any

    environment {
        CONTAINER_ID = ''
        SUM_PY_PATH = './sum.py'
        DIR_PATH = './'
        TEST_FILE_PATH = './test_variables.txt'
    }

    stages {
        stage('Build') {
            steps {
                script {
                    sh 'docker build -t python-sum-app .'
                }
            }
        }
        stage('Run') {
            steps {
                script {
                    def output = sh(script: 'docker run -d python-sum-app', returnStdout: true).trim()
                    CONTAINER_ID = output
                }
            }
        }
        stage('Test') {
            steps {
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
            sh "docker stop ${CONTAINER_ID}"
            sh "docker rm ${CONTAINER_ID}"
        }
    }
}
