pipeline {
    agent any

    environment {
        // Cambio realizado: Leemos la IP del registry dinámicamente desde un archivo en el servidor de Jenkins.
        // Por qué se realizó: Para evitar la IP "quemada" (10.116.0.2), lo cual fallará en nuevos despliegues de Terraform.
        REGISTRY = sh(script: 'cat /var/lib/jenkins/registry_ip.txt', returnStdout: true).trim()
        IMAGE_NAME = 'app-springboot'
        IMAGE_TAG = "${env.BUILD_ID}"
    }

    stages {
        stage('Build with Maven') {
            steps {
                script {
                    echo "Compilando la aplicación Spring Boot..."
                    // Cambio realizado: Se descomentó la compilación de Maven.
                    // Por qué se realizó: Subir archivos binarios (como .jar) a Git es mala práctica; el CI (Jenkins) es el que debe compilarlo en este paso.
                    sh "chmod +x mvnw"
                    sh "./mvnw clean test package"
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    echo "Construyendo la imagen Docker para Spring Boot..."
                    sh "docker build -t ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} -t ${REGISTRY}/${IMAGE_NAME}:latest ."
                }
            }
        }
        stage('Push to Registry') {
            steps {
                script {
                    echo "Enviando imagen al registro interno..."
                    sh "docker push ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker push ${REGISTRY}/${IMAGE_NAME}:latest"
                }
            }
    }
}
}
