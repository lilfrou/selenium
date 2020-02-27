pipeline {
    agent any
    stages {
        stage('file write') {
            steps{
                sh "echo version := \\\"1.0.${env.BUILD_ID}\\\" >> build.html"
                publishHTML (target: [
                                allowMissing: false,
                                alwaysLinkToLastBuild: false,
                                keepAll: true,

                                reportFiles: 'build.html',
                                reportName: "monitor"
                                           ])
            }
        }
    }
}
