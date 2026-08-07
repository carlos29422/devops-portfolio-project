pipeline {
    agent any

    environment {
        IMAGE_NAME = "devops-portfolio-api:${BUILD_NUMBER}"
    }

    stages {
        stage('Lint & Static Analysis') {
            steps {
                echo 'Iniciando verificación de código...'
                sh 'flake8 app/main.py --max-line-length=120 --ignore=E501,W503,W292 || true'
                sh 'shellcheck scripts/*.sh || true'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Compilando imagen de contenedor...'
                sh 'docker build -t ${IMAGE_NAME} ./app'
            }
        }

        stage('Security Audit') {
            steps {
                echo 'Ejecutando escaneo Trivy...'
                sh 'trivy image --severity HIGH,CRITICAL ${IMAGE_NAME} || true'
            }
        }
    }

    post {
        always {
            echo 'Limpiando artefactos de la compilación...'
            sh 'docker rmi ${IMAGE_NAME} || true'
        }
    }
}