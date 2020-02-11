def analyse="true"
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
           stage('sonar') {
             steps {
                  catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
              script{
                  try { 
                  if (env.BRANCH_NAME.startsWith('PR-'))
                  {
                       sh " mvn verify sonar:sonar \
                    -Dsonar.projectKey=lilfrou_selenium \
                    -Dsonar.organization=lilfrou-github \
                    -Dsonar.host.url=https://sonarcloud.io \
                    -Dsonar.login=b9424f7d0ef3247f0ba6bec3d93d2be3382fb019 \
                    -Dsonar.pullrequest.base='${CHANGE_TARGET}' \
                    -Dsonar.pullrequest.branch='${env.BRANCH_NAME}' \
                    -Dsonar.pullrequest.key='${env.CHANGE_ID}' \
                    -Dsonar.pullrequest.provider=GitHub \
                    -Dsonar.pullrequest.github.repository=lilfrou/selenium"
                  }
                        else if((env.BRANCH_NAME=="Deploy")||(env.BRANCH_NAME=="Test-selenium"))
                  {
                      echo 'no analyse allowed'
                  } 
                 else {
             sh " mvn verify sonar:sonar \
                    -Dsonar.projectKey=lilfrou_selenium \
                    -Dsonar.organization=lilfrou-github \
                    -Dsonar.host.url=https://sonarcloud.io \
                    -Dsonar.branch.name='${env.BRANCH_NAME}' \
                    -Dsonar.login=b9424f7d0ef3247f0ba6bec3d93d2be3382fb019"
                  }
                  
                       } catch (Exception e) {
                analyse="false"
               sh "exit 1"}
                  }
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
         
        
          stage('nexus-upload') {
             steps {
              sh "echo nexus"        
        }
    } 
}    

}
