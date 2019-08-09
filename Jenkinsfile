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
    
     stage('sonar') {
         steps{
               sh 'mvn sonar:sonar\
  -Dsonar.projectKey=lilfrou_selenium\
  -Dsonar.organization=lilfrou-github\
  -Dsonar.host.url=https://sonarcloud.io\
  -Dsonar.login=33b8b6e55f893798be4dfec2d7a10674105a4890'
     }
     }
}
    post {
        always {
            step([$class: 'Publisher', reportFilenamePattern: '**/testng-results.xml'])
            
        }
}
}
