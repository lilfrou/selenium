pipeline {
    agent any
stages {
        stage("clone code") {
            steps {
                script {
                    // Let's clone the source
                    git 'https://github.com/lilfrou/pipline.git';
                    sh "mvn clean verify"
                }
            }
        }
    
         stage('selenium') {
            steps {
                sh "mvn clean test"
            }
        }
    }
}
