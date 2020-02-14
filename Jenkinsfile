def analyse="true"
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
def fg = 30
def bg = 46
def style = "${(char)27}[$fg;$bg"+"m"
pipeline {
    agent any
    tools {
        maven 'maven3.6.1'
        jdk 'jdk'
    }

     stages {  
              stage('build') {
                     when {
                branch 'Develop'
            }  
             steps {
                 sh"println(style+"HELLO")"
              sh "mvn install -DskipTests"        
        }
    } 
            stage('test') {
                        when {
                branch 'Develop'
            }  
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
                       when {
                branch 'Develop'
            }  
            
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
                      when {
                branch 'Develop'
            }  
             steps {
              sh "echo nexus"        
        }
          }
         stage('Deploy to \ndev-mirror') {
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
                             choices: ['Dev','Mirror'].join('\n'),
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
                         name: 'Reminder - the Stage will abort itself soon',
                description: "You Have '${j}' Trys Left"]])
                    i++;
                       if(i==3 && ("${userInput1}" != "${password}")){
                      unstable('Sending email to admin !')
                    sh"exit 1"
                    }
                   }
                }
            }
            
            if( "${USER_INPUT}" == "Mirror"){
                sh"mvn -Pmirror clean install"
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
           
                
             
          stage('Release-to-ProD') {
                      when {
                branch 'master'
            }  
             steps {
                   catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {         
            script {
            // Define Variable
            timeout(time: 1, unit: 'MINUTES') {
                
             USER_INPUT1 = input(
                    message: 'Are you sure you want to Deploy to the PROD Envireronment?',
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
                          
                    unstable('Sending email to admin !')
                          sh"exit 1"
                    }
             
                      
                         }
              }
                
                 }
            }
                if( "${USER_INPUT1}" == "No"){
                   //currentBuild.result = 'ABORTED'
                   
                   unstable('No was Selected!')
    //error('Stopping early…')
                }
       
            if( "${USER_INPUT1}" == "Yes"){
                sh"mvn -Pprod clean install"
            }
              
            }
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
                          
                    unstable('Sending email to admin !')
                          sh"exit 1"
                    }
             
                      
                         }
              }
                
                 }
            }
                if( "${USER_INPUT2}" == "No"){
                   //currentBuild.result = 'ABORTED'
                   unstable('No was Selected!')
    //error('Stopping early…')
                }
       
            if( "${USER_INPUT2}" == "Yes"){
                sh"mvn -Pprod clean install"
            }
              
            }
            }
             }
           }
           
    
         stage('Clean'){     
          steps{  
                script{
                cleanWs()
                    currentBuild.result = 'SUCCESS'
                    }
                 
                }
          }
         
}    
    post {
        always {
            mail to: 'fmhenni@hrdatabank.com, mhennifiras100@gmail.com', from: 'jenkins',
                subject: "${env.JOB_NAME} - Failed", 
                body: "Job Failed - \"${env.JOB_NAME}\" build: ${env.BUILD_NUMBER}\n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
        }
    }

}
