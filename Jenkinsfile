pipeline {
    agent any
    stages {
        stage('file write') {
            steps{
                sh "echo version := \\\"1.0.${env.BUILD_ID}\\\" >> build.sbt"
            }
        }
    }
}
