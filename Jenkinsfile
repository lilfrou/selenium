pipeline {
    agent any
    tools {
        maven 'maven3.6.1'
        jdk 'jdk'
    }
     stages {
      
        stage("clone code") {
            steps {
                script {
                    // Let's clone the source
                    git 'https://github.com/lilfrou/selenium.git';
                }
            }
        }
  
    stage('compile') {
             steps {
              sh "mvn clean compile"        
        }
    } 
         stage('test') {
             steps {
              sh "mvn test"        
        }
    } 
           stage('package') {
             steps {
              sh "mvn package"        
        }
    } 
              stage('install') {
             steps {
              sh "mvn install"        
        }
    } 
              stage('deploy') {
             steps {
              sh "mvn deploy"        
        }
    } 
}    

}
