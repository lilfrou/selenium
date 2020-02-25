pipeline {
    agent none
    stages {
        stage('Parallel Stage') {
            parallel {
                stage('Stage 1') {
                    agent any
                     stages {
                           stage('Cron'){
                    steps {
                        echo "Stage 1"
                    }
                }
                stage('Stage 2') {
                    steps {
                        script {
                            parallel (
                                "Stage 2.1.": {
                                    echo "Stage 2.1."
                                },
                                "Stage 2.2.": {
                                    echo "Stage 2.2."
                                }
                            )
                        }
                    }
                }
            }
             
        }
                       stage("Main") {
                     agent any
                    stages {
         stage("Verify Mirror-ProD"){
             steps{
                 sh"echo hi"
             }
         }
                    }
                    }
    }
}
    }
}
