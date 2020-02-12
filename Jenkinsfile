def analyse="true"
pipeline {
    agent any
    tools {
        maven 'maven3.6.1'
        jdk 'jdk'
    }
     stages {  
              stage('build') {
             steps {
              sh "mvn install -DskipTests"        
        }
    } 
            stage('test') {
             steps {
              sh "mvn -pl !dashboardSelenium test"      
        }
    } 
         
        
          stage('nexus-upload') {
             steps {
              sh "echo nexus"        
        }
    } 
}    

}
