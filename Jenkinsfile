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
  
    stage('cleaning stage') {
             steps {
              sh "mvn clean install" 
            
                 
         
                
        }
    } 
        
}    

}
