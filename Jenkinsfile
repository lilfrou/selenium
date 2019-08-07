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
     stage('test JUNIT') {
             steps {
              sh "mvn -Dtest=additiontest test"
               
        }
    }  
         stage('selenium') {
            steps {
                sh "mvn clean test -DsuiteXmlFile=testng.xml"
              
            }   
      }   
}
    post {
        always {
            step([$class: 'Publisher', reportFilenamePattern: '**/testng-results.xml'])
            junit '**/junitreports/*.xml'
        }
}
}
