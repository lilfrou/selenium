pipeline {
    agent none
    stages {
        stage("Cron || Normal") {
            parallel {
                stage("Crons") {
                     agent any
                    stages {
          stage('Cron'){
               steps{
                 sh"echo hello"
                 
             }
         }
                    }
                }
            
        
         stage("Crons"1) {
                     agent any
                    stages {        
        stage('Parallel Stage') {
            
            parallel {
                stage('Stage 1') {
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
                                }
                                }
                                }
                            )
                        }
                    }
                }
            }
        }
    }
}
}
