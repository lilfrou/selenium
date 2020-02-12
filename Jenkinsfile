def analyse="true"
def USER_INPUT=""
def password="hrdatabank**"
def inputConfig=""
def userInput1=""
def i=1
pipeline {
    agent any
    tools {
        maven 'maven3.6.1'
        jdk 'jdk'
    }

     stages {  
           stage('dev-mirror') {
              when {
                branch 'Deploy'
            }  
             steps {
              catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {         
            script {
            // Define Variable
            timeout(time: 1, unit: 'MINUTES') {
                
             USER_INPUT = input(
                    message: 'Whats is the environment you would like to deploy in ?',
                    parameters: [
                            [$class: 'ChoiceParameterDefinition',
                             choices: ['Dev','Prod'].join('\n'),
                             name: 'input',
                             description: 'Chose Wise - the pipeline will abort itself in 1 Minute ']
                    ])
                
               
                       userInput1 = input(id: 'userInput',
   message: 'Please type the password?',
   parameters: [[$class: 'PasswordParameterDefinition',
                         defaultValue: "",
                         name: 'password',
                description: 'Reminder - the pipeline will abort itself in less then  1 Minute ']])
                echo "The answer is: ${userInput1}"
                 
                while("${userInput1}" != "hrdatabank**") { 
                     
                    
                       userInput1 = input(id: 'userInput',
   message: 'Please type the password?',
   parameters: [[$class: 'PasswordParameterDefinition',
                         defaultValue: "",
                         name: 'password',
                description: ' Reminder - the pipeline will abort itself soon ']])
                    i++;
                    if(i==3){
                    sh"exit 1"
                    }
                    
                }
                 
            echo "The answer is: ${USER_INPUT}"
            if( "${USER_INPUT}" == "Prod"){
                sh"mvn -Pprod clean install"
            }
                else if( "${USER_INPUT}" == "Dev"){
                sh"mvn -Pdev clean install"
                }
                else {
                sh"echo no deploy"
                }
            }
            }
             }
           }
           }
       
              stage('build') {
             steps {
              sh "mvn install -DskipTests"        
        }
    } 
            stage('test') {
             steps {
                 sh"mvn test"
              //sh "mvn -pl !dashboardSelenium test"      
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
           stage('javadoc'){   
            
          steps{   
                    sh"mvn javadoc:aggregate"   
                    publishHTML (target: [
                                allowMissing: false,
                                alwaysLinkToLastBuild: false,
                                keepAll: true,
                                reportDir: 'target/site/apidocs',

                                reportFiles: 'index.html',
                                reportName: "javadoc"
                                           ])
       
           }
         }
          stage('selenium') {
             steps {
              sh "echo nexus"        
        }
          }
                stage('deploy') {
             steps {
              sh "echo nexus"        
        }
                }
              
         
          stage('nexus-upload') {
             steps {
              sh "echo nexus"        
        }
    } 
}    

}
