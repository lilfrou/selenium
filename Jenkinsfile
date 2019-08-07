pipeline {
    agent any
stages {
        stage("clone code") {
            steps {
                script {
                    // Let's clone the source
                    git 'https://github.com/lilfrou/selenium.git';
                }
            }
        }
    stage('compile stage') {
             steps {
              sh "mvn clean compile"
                 
               
        }
    }  
         stage('selenium') {
            steps {
                sh "mvn clean test -DsuiteXmlFile=testng.xml"
              sh "mvn clean cobertura:cobertura" 
            }   
             post {

  always {
    cobertura coberturaReportFile: 'target/site/cobertura/coverage.xml'
    }
}


      }   
}
    post {
        always {
            step([$class: 'Publisher', reportFilenamePattern: '**/testng-results.xml'])
            
        }
}
}
