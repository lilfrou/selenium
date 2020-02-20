def USER_INPUT=""
def userInput1=""
def USER_INPUT1=""
def userInput2=""
def USER_INPUT2=""
def userInput3=""
def i=1
def j=3
def l=1
def k=3
def m=1
def n=3
def build="true"
def test="true"
def selenium="true"
def javadoc="true"
def analyse="true"
def deploy="true"
def release="true"
def upload="true"
def p1="true"
def p2="true"
def p3="true"
pipeline {
    agent any
    tools {
        maven 'maven3.6.1'
        jdk 'jdk'
        nodejs 'node' 
    }

     stages {  
              stage('build') {
                     when {
                branch 'Develop'
            }  
                   steps {
                  catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                      script {  
                           try { 
      
              sh "mvn install -DskipTests" 
              sh "cd my-app && npm install"
              sh "cd my-app && npm run build"   
                  } catch (Exception e) {
                build="false"
//slackSend (color: '#000000',channel:'#dashbord_backend_feedback', message: "STARTED: Job '${env.BRANCH_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
slackSend (color: '#C60800',channel:'#dashbord_backend_feedback', message: "${env.STAGE_NAME} STAGE FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'")
               sh "exit 1"}                              }
                      }
        }
                 
    } 
            stage('test') {
                        when {
                branch 'Develop'
            }  
             steps {
                 catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                      script {  
                           try { 
                 sh"mvn test"
              //sh "mvn -pl !dashboardSelenium test"  
                } catch (Exception e) {
                test="false"
slackSend (color: '#C60800',channel:'#dashbord_backend_feedback', message: "${env.STAGE_NAME} STAGE FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'")
               sh "exit 1"}                              }
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
   slackSend (color: '#C60800',channel:'#dashbord_backend_feedback', message: "${env.STAGE_NAME} STAGE FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'")                    
               sh "exit 1"}
                  }
             }
           }
          }   
           stage('javadoc'){   
                       when {
                branch 'Develop'
            }  
            
          steps{ 
               catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                      script {  
                           try { 
                    sh"mvn javadoc:aggregate"   
                    publishHTML (target: [
                                allowMissing: false,
                                alwaysLinkToLastBuild: false,
                                keepAll: true,
                                reportDir: 'target/site/apidocs',

                                reportFiles: 'index.html',
                                reportName: "javadoc"
                                           ])
                                } catch (Exception e) {
                javadoc="false"
slackSend (color: '#C60800',channel:'#dashbord_backend_feedback', message: "${env.STAGE_NAME} STAGE FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'")
               sh "exit 1"}                              }
                 }
       
           }
         }
          stage('selenium') {
                      when {
                branch 'Develop'
            }  
             steps {
                   catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                      script {  
                           try { 
              sh "echo nexus"  
                                 } catch (Exception e) {
                selenium="false"
slackSend (color: '#C60800',channel:'#dashbord_backend_feedback', message: "${env.STAGE_NAME} STAGE FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'")
               sh "exit 1"}                              }
                 }
        }
          }
          stage('Deploy-to-Dev') {
                      when {
                branch 'Develop'
            }  
             steps {
                   catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {         
            script {
            // Define Variable
            timeout(time: 1, unit: 'MINUTES') {
                
             USER_INPUT1 = input(
                    message: 'Are you sure you want to Deploy to the Dev environment?',
                    parameters: [
                            [$class: 'ChoiceParameterDefinition',
                             choices: ['Yes','No'].join('\n'),
                             name: 'input',
                             description: 'Chose Wise - the Stage will abort itself in 1 Minute ']
                    ])
                 if( "${USER_INPUT1}" == "Yes"){
              withCredentials([string(credentialsId: 'password', variable: 'password')]) {
                     
                       userInput2 = input(id: 'userInput',
   message: 'Please type the password?',
   parameters: [[$class: 'PasswordParameterDefinition',
                         defaultValue: "",
                         name: 'Reminder - the Stage will abort itself in less then  1 Minute',
                 description: "You Have '${k}' Trys Left"]])
               
                 
                   while("${userInput2}" != "${password}") { 
                     k--;
                    
                       userInput2 = input(id: 'userInput',
   message: 'Please type the password?',
   parameters: [[$class: 'PasswordParameterDefinition',
                         defaultValue: "",
                         name: 'Reminder - the Stage will abort itself soon',
                description: "Wrong Password! \nYou Have '${k}' Trys Left"]])
                    l++;
                       if(l==3 && ("${userInput2}" != "${password}")){
                          
                     unstable('"\033[1;33m Sending email to admin ! \033[0m"')
                 mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "Security Raison ${env.STAGE_NAME} Stage", 
                body: "Some-one has typed A Wrong secret password 3 Times successively for the ${env.JOB_NAME} Pipline!\n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
                       p2="false"
                           return
                    }
             
                      
                         }
              }
                
                 }
            }
                if( "${USER_INPUT1}" == "No"){
                   //currentBuild.result = 'ABORTED'
                   
                   unstable('"\033[1;33m No was Selected! \033[0m"')
                    return
    //error('Stopping early…')
                }
                try{
            if( ("${USER_INPUT1}" == "Yes")&&(p2=="true")){
                sh"mvn -Pdev clean install"
            }
                     } catch (Exception e) {
                release="false"
slackSend (color: '#C60800',channel:'#dashbord_backend_feedback', message: "${env.STAGE_NAME} STAGE FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'")
                mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "Deploying to Development environement ${env.JOB_NAME} - Failed", 
                body: "This is an Urgent Problem ! \n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
               sh "exit 1"}    
              
            }
            }
             }
               post { 
        success {
            mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "Development environement  ${env.JOB_NAME} has been Updated- ", 
                body: " Please verify if every thing is working fine! \n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
        }
              }
           }
         stage('Release to mirror-Prod') {
              when {
                branch 'master'
            }  
             steps {
              catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {         
            script {
            // Define Variable
            timeout(time: 1, unit: 'MINUTES') {
             USER_INPUT = input(
                    message: 'Whats is the environment you would like to Release in ?',
                    parameters: [
                            [$class: 'ChoiceParameterDefinition',
                             choices: ['Mirror','Prod'].join('\n'),
                             name: 'input',
                             description: 'Chose Wise - the Stage will abort itself in 1 Minute ']
                    ])
                
              withCredentials([string(credentialsId: 'password', variable: 'password')]) {
                     
                       userInput1 = input(id: 'userInput',
   message: 'Please type the password?',
   parameters: [[$class: 'PasswordParameterDefinition',
                         defaultValue: "",
                         name: 'Reminder - the Stage will abort itself in less then  1 Minute',
                 description: "You Have '${j}' Trys Left"]])
               
                 
                   while("${userInput1}" != "${password}") { 
                     j--;
                    
                       userInput1 = input(id: 'userInput',
   message: 'Please type the password?',
   parameters: [[$class: 'PasswordParameterDefinition',
                         defaultValue: "",
                         name: "Reminder - the Stage will abort itself soon",
                description: "Wrong Password! \nYou Have '${j}' Trys Left"]])
                    i++;
                       if(i==3 && ("${userInput1}" != "${password}")){
          
                      unstable('"\033[1;33m Sending email to admin ! \033[0m"')
                    
                mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "Security Raison ${env.STAGE_NAME} Stage", 
                body: "Some-one has typed A Wrong secret password 3 Times successively for the ${USER_INPUT} environment for ${env.JOB_NAME} Pipline!\n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
                 p1="false"
                           return 
                          
                    }  
              }
                      
                }
            }
                try{
            if( ("${USER_INPUT}" == "Mirror") &&(p1=="true") ){
                sh"mvn -Pmirror clean install"
            }
                else if( ("${USER_INPUT}" == "Prod") && (p1=="true")){
                sh"mvn -Pprod clean install"
                }
                else {
                sh"echo no deploy"
                }
                     } catch (Exception e) {
                deploy="false"
slackSend (color: '#C60800',channel:'#dashbord_backend_feedback', message: "${env.STAGE_NAME} STAGE FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'")
                mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "Releasing to ${USER_INPUT} environement ${env.JOB_NAME} - Failed", 
                body: "This is an Urgent Problem ! \n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
               sh "exit 1"}    
            }
            }
             }
              post { 
        success {
            mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "${USER_INPUT} environement  ${env.JOB_NAME} has been Updated- ", 
                body: " Please verify if every thing is working fine! \n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
        }
              }
           }
                
             stage('nexus-upload') {
                            when {
                branch 'master'
            }  
             steps {
      catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {         
            script {
            // Define Variable
            timeout(time: 1, unit: 'MINUTES') {
                
             USER_INPUT2 = input(
                    message: 'Do you want to Store backup to nexus ?',
                    parameters: [
                            [$class: 'ChoiceParameterDefinition',
                             choices: ['Yes','No'].join('\n'),
                             name: 'input',
                             description: 'Chose Wise - the Stage will abort itself in 1 Minute ']
                    ])
                 if( "${USER_INPUT2}" == "Yes"){
              withCredentials([string(credentialsId: 'password', variable: 'password')]) {
                     
                       userInput3 = input(id: 'userInput',
   message: 'Please type the password?',
   parameters: [[$class: 'PasswordParameterDefinition',
                         defaultValue: "",
                         name: 'Reminder - the Stage will abort itself in less then  1 Minute',
                 description: "You Have '${n}' Trys Left"]])
               
                 
                   while("${userInput3}" != "${password}") { 
                     n--;
                    
                       userInput3 = input(id: 'userInput',
   message: 'Please type the password?',
   parameters: [[$class: 'PasswordParameterDefinition',
                         defaultValue: "",
                         name: 'Reminder - the Stage will abort itself soon',
                description: "Wrong Password! \nYou Have '${n}' Trys Left"]])
                    m++;
                       if(m==3 && ("${userInput3}" != "${password}")){
                          
                     unstable('"\033[1;33m Sending email to admin ! \033[0m"')
                 mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "Security Raison ${env.STAGE_NAME} Stage", 
                body: "Some-one has typed A Wrong secret password 3 Times successively for the ${env.JOB_NAME} Pipline!\n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
                        p3="false"
                           return
                    }
             
                      
                         }
              }
                
                 }
            }
                if( "${USER_INPUT2}" == "No"){
                   //currentBuild.result = 'ABORTED'
                   unstable('"\033[1;33m No was Selected! \033[0m"')
                    return
    //error('Stopping early…')
                }
                try{
            if( ("${USER_INPUT2}" == "Yes")&&(p3=="true")){
                sh"mvn -Pprod clean install"
            }
                     } catch (Exception e) {
                upload="false"
slackSend (color: '#C60800',channel:'#dashbord_backend_feedback', message: "${env.STAGE_NAME} STAGE FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'")
                mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "Uploading to Nexus ${env.JOB_NAME} - Failed", 
                body: "This is an Urgent Problem ! \n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
               sh "exit 1"}    
              
            }
            }
             }
                  post { 
        success {
            mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "Nexus backup  ${env.JOB_NAME} has been Updated- ", 
                body: " Did you stored a snapshot backup for the oldest version! \n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
        }
              }
           }
           
    
         stage('Clean'){     
          steps{  
                script{
                cleanWs()
                   
              
  if(build=="false" || test=="false" ||  javadoc=="false" || analyse=="false" || selenium=="false" || deploy=="false" || release=="false" || upload=="false"){
                       currentBuild.result = 'FAILURE'  }
                    }
                 
                }
          }
         
}    
   

}
