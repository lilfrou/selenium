pipeline {
    agent any
    stages {
        stage('file write') {
            steps{
                script {  
                           try { 
                sh "echo version := \\\"1.0.${env.BUILD_ID}\\\" >> build.html"
                publishHTML (target: [
                                allowMissing: false,
                                alwaysLinkToLastBuild: false,
                                keepAll: true,
                                reportDir: '/var/lib/jenkins/workspace/dashboard-back_file-write',
                                reportFiles: 'build.html',
                                reportName: "monitor"
                                           ])
                               } catch (Exception e) {
                           sh"echo fail"}
                }
            
            }
        }
    }
}
