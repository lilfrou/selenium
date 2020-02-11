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
         
          stage('sonar') {
             steps {
              sh " mvn verify sonar:sonar \
                    -Dsonar.projectKey=lilfrou_selenium \
                    -Dsonar.organization=lilfrou-github \
                    -Dsonar.host.url=https://sonarcloud.io \
                    //-Dsonar.branch.name='${env.BRANCH_NAME}' \
                    -Dsonar.login=b9424f7d0ef3247f0ba6bec3d93d2be3382fb019"

                  }
          }
          stage('nexus-upload') {
             steps {
              sh "echo nexus"        
        }
    } 
}    

}
