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
                 sh"mvn clean verify"
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
              sh 'mvn -X clean verify sonar:sonar\
 -Dsonar.projectKey=lilfrou_selenium\
 -Dsonar.organization=lilfrou-github\
 -Dsonar.host.url=https://sonarcloud.io\
 -Dsonar.login=aea4ae9047ac47d6e0b367b0a12c8d239bbaa1da\
 -Dsonar.branch.name=lilfrou-patch-1'

    }
    }
    
}
    post {
        always {
            step([$class: 'Publisher', reportFilenamePattern: '**/testng-results.xml'])
            
        }
}
}
