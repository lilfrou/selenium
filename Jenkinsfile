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
                    -Dsonar.projectKey=will-technologies_DashBoard_backend \
                    -Dsonar.organization=will-technologies \
                    -Dsonar.host.url=https://sonarcloud.io \
                    //-Dsonar.branch.name='${env.BRANCH_NAME}' \
                    -Dsonar.login=fb60b36f6cd512ae8112d13c1e621de98418ff61"

                  }
          stage('nexus-upload') {
             steps {
              sh "echo nexus"        
        }
    } 
}    

}
