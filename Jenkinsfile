def USER_INPUT3=""
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
def Cron="true"
def backup="true"
def verif="true"
def monitor="true"

pipeline {
    agent {
    node {
        label 'maître'
    }
}
    tools {
        maven 'maven3.6.1'
        jdk 'jdk'
        nodejs 'node' 
    }
    triggers {
    cron(env.BRANCH_NAME == 'Cron' ? 'H/5 * * * *' : '')
  }
/**parameters {
        choice(
            choices: ['greeting' , 'silence'],
            description: '',
            name: 'REQUESTED_ACTION')
    }*/
     stages {  
       
         stage("Crons || Main") {
            parallel {
                stage("Crons") {
                     agent {
    node {
        label 'maître'
    }
}
                    stages {
          stage('Cron'){
         when {
                branch 'Cron'
            }  
         
             steps{
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { 
                 script{
                     try{
                                   sh"chmod +x hello.sh"
                                   sh "./hello.sh" 
                        } catch (Exception e) {
                Cron="false"
//slackSend (color: '#000000',channel:'#dashbord_backend_feedback', message: "STARTED: Job '${env.BRANCH_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
slackSend (color: '#C60800',channel:'#dashbord_backend_feedback', message: "${env.STAGE_NAME} STAGE FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'")
                mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "PRoduction environement is DoWn !!! ${env.JOB_NAME}", 
                body: "This is an Urgent Problem ! \nTrying to Restore backup from nexus! Please Stand by... \n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
               sh "exit 1"}     
                 }
             }
         }
                    }
                        /** stage('Monitoring'){
         when {
                branch 'Cron'
            }  
         
             steps{
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { 
                 script{
                     try{
                          parallel (
                         "jenkins.sh": {
                                    sh"chmod +x info.sh"
        
                             sh "./info.sh > build.html"
    sh"cp -r /var/lib/jenkins/workspace/dashboard-back_Cron*//**build.html /var/lib/jenkins/workspace/dashboard-back_Cron"
                               publishHTML (target: [
                                allowMissing: false,
                                alwaysLinkToLastBuild: false,
                                keepAll: true,
                                reportDir: '/var/lib/jenkins/workspace/dashboard-back_Cron',
                                reportFiles: 'build.html',
                                reportName: "monitor"
        ])
                                },
                          "nexus.sh": {
                  withCredentials([string(credentialsId: 'secret-nexus', variable: 'secret-nexus')]) {
                       //sudo sshpass -p '45nexus**' scp -r root@192.168.1.45:pass.sh pass.sh
                       sh'sshpass -p "45nexus**" ssh -o StrictHostKeyChecking=no root@192.168.1.45 ./info.sh'
                               
                   }
                                },
                          "Tom-Front.sh": {
                              sshagent(['firas-pem']) {
    sh 'scp -o StrictHostKeyChecking=no info.sh root@192.168.1.100:info.sh'
    sh 'ssh -o StrictHostKeyChecking=no root@192.168.1.100 "sudo chmod +x info.sh;./info.sh"'
                              }
                                }
                          )
                          } catch (Exception e) {
                         monitor="false"
 slackSend (color: '#C60800',channel:'#dashbord_backend_feedback', message: "${env.STAGE_NAME} STAGE FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'")
                         mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "MOnitoring stage has some problem !!! ${env.JOB_NAME}", 
                body: "This is an Urgent Problem ! \nPLease check the Problem source \n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
                     sh "exit 1"}
                 }
                }
             }
                         }*/
                         
                          stage('Backup'){
         when {
                expression{
     ((env.BRANCH_NAME=="Cron") && (Cron=="false")) ;
                }
            }  
         
             steps{
                  catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { 
                 script{
                     try{
                  sshagent(['firas-pem']) {
      sh 'ssh -o StrictHostKeyChecking=no root@192.168.1.100 "sudo pkill -9 java;sudo rm -Rf /opt/apache-tomcat-8.5.45/webapps/ROOT*"'
          
      sh 'ssh -o StrictHostKeyChecking=no root@192.168.1.100 "sudo curl --output /opt/apache-tomcat-8.5.45/webapps/ROOT.war -u admin:**HRDatabank** http://192.168.1.45:8081/repository/maven-releases/myproject/myproject/1.0.2/myproject-1.0.2.war"'
      sh 'ssh -o StrictHostKeyChecking=no root@192.168.1.100 "sudo chmod -R 777 /opt/apache-tomcat-8.5.45/webapps/*.war"'

         }
                 sshagent(['firas-pem']) {
    sh 'ssh -o StrictHostKeyChecking=no root@192.168.1.100 "sudo rm -Rf /opt/apache-tomcat-8.5.45/webapps2/ROOT*"'
    sh 'ssh -o StrictHostKeyChecking=no root@192.168.1.100 "sudo curl --output /opt/apache-tomcat-8.5.45/webapps2/ROOT.tgz -u admin:**HRDatabank** http://192.168.1.45:8081/repository/npm-private/my-app/-/my-app-0.0.0.tgz"'
    sh 'ssh -o StrictHostKeyChecking=no root@192.168.1.100 "sudo tar -xvzf /opt/apache-tomcat-8.5.45/webapps2/ROOT.tgz -C /opt/apache-tomcat-8.5.45/webapps2/;mv -T /opt/apache-tomcat-8.5.45/webapps2/package/dist/my-app/ /opt/apache-tomcat-8.5.45/webapps2/ROOT;rm -rf /opt/apache-tomcat-8.5.45/webapps2/package;sudo chmod -R 777 /opt/apache-tomcat-8.5.45/webapps2/R*;sudo /opt/apache-tomcat-8.5.45/bin/catalina.sh start &"'
                 }
                          } catch (Exception e) {
                backup="false"
//slackSend (color: '#000000',channel:'#dashbord_backend_feedback', message: "STARTED: Job '${env.BRANCH_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
slackSend (color: '#C60800',channel:'#dashbord_backend_feedback', message: "${env.STAGE_NAME} STAGE FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'")
                mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "Nexus has failed to restore Prodection environment!!! ${env.JOB_NAME}", 
                body: "This is an Urgent Problem ! \nFor some raison nexus has failed to restore backup , humains interfering is needed \n checking for The Production environment health status again ...!! \n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
               sh "exit 1"}  
                 }
                  }

             }
               post { 
        always {
            script{
                if( (backup== "true")){
            mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "Production environment has been restored from Nexus backup ${env.JOB_NAME}", 
                body: " Please stand by we are checking for Production environment health status ! \n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
        }
            }
        }
              }                
                          
                        
                          }
                        stage('Verification'){
         when {
                expression{
     ((env.BRANCH_NAME=="Cron") && (Cron=="false")) ;
                }
            }  
         
             steps{
                  catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { 
                 script{
                     try{
                         sh"chmod +x hello.sh"
                         sh "./hello.sh"
                          } catch (Exception e) {
                verif="false"
//slackSend (color: '#000000',channel:'#dashbord_backend_feedback', message: "STARTED: Job '${env.BRANCH_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
slackSend (color: '#C60800',channel:'#dashbord_backend_feedback', message: "${env.STAGE_NAME} STAGE FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'")
                         if(backup=="true"){
                mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "the Prodection environment is still Down even after nexus Backup!!! ${env.JOB_NAME}", 
                body: "This is an Urgent Problem ! \nHumains interfering is needed \n The Production environment will keep Down until manual interfering!! \n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
               sh "exit 1"}
                         if(backup=="false"){
                mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "the Prodection environment is still Down!!! ${env.JOB_NAME}", 
                body: "This is an Urgent Problem ! \nNexus backup has failed !! Humains interfering is needed \n The Production environment will keep Down until manual interfering for nexus!! \n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
               sh "exit 1"}
                     }
                 }
                  }
                }
                              post { 
        always {
            script{
                if(verif== "true"){
            mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "The Production environment is Back OnLine ${env.JOB_NAME}", 
                body: " Please verify if every thing is working fine! \n\nhttp://192.168.1.100/ ! \n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
        }
              
            }
        }
              }                
                }
                          }
                    }
                    
                 stage("Main") {
                      agent {
    node {
        label 'maître'
      
    }
}
                    stages {
         stage("Verify Mirror-ProD"){
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
                
             
              }
                      
                }
            }
            }
              }
        
         
        
              stage('build') {
                                          when {
                                               not {
                                             expression{
     (env.BRANCH_NAME.contains("PR-")) || (env.BRANCH_NAME=="Test-selenium") || (env.BRANCH_NAME=="Cron") ;
                }
                                               }
            }  
          
                   steps {
                  catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                      script {  
                           try { 
      
                 if((env.BRANCH_NAME=="master") && ("${USER_INPUT}" == "Mirror") &&(p1=="true") )
                               {
                                  sh "mvn -Pmirror clean install -DskipTests" 
              sh "cd my-app && npm install"
                                   sh "cd my-app && npm run build"  
                               }
                               else if((env.BRANCH_NAME=="master") && ("${USER_INPUT}" == "Prod") &&(p1=="true"))
                               {
                                   sh "mvn -Pprod clean install -DskipTests" 
              sh "cd my-app && npm install"
                                   sh "cd my-app && npm run build"  
                               }
                               else if (env.BRANCH_NAME!="master")
                               {
              sh "mvn -Pdev clean install -DskipTests" 
              sh "cd my-app && npm install"
                                   sh "cd my-app && npm run build" }
                               else {
                                   unstable('"\033[1;33m No build allowed ! \033[0m"')
                                   build="false"
                               }
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
                  not {
                                             expression{
     (env.BRANCH_NAME.contains("PR-")) || (env.BRANCH_NAME=="Test-selenium") || (env.BRANCH_NAME=="Cron") ;
                }
                                               }
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
       stage('sonar||PR-') {
              when {
                  not {
          anyOf {
            branch 'Test-selenium';
            branch 'Cron'
          }
       }
                
            }  

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
                 not {
                                             expression{
     (env.BRANCH_NAME.contains("PR-")) || (env.BRANCH_NAME=="Test-selenium") || (env.BRANCH_NAME=="Cron") ;
                }
                                               }
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
                branch 'Test-selenium'
            }  
             steps {
                   catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                      script {  
                           try { 
              sh "echo selenium"  
                                 } catch (Exception e) {
                selenium="false"
slackSend (color: '#C60800',channel:'#dashbord_backend_feedback', message: "${env.STAGE_NAME} STAGE FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'")
               sh "exit 1"}                              }
                 }
        }
          }
          stage('Deploy-to-Dev') {
                      when {
                 expression{
                                    
    (env.BRANCH_NAME == 'Develop') && (build=="true");
              }               
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
            if( ("${USER_INPUT1}" == "Yes")&&(p2=="true") && (build=="true")){
                sh"mvn -Pdev clean install"
                
            }
                    else{
                        sh"echo NO Deploy"
                    }
                     } catch (Exception e) {
                deploy="false"
slackSend (color: '#C60800',channel:'#dashbord_backend_feedback', message: "${env.STAGE_NAME} STAGE FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'")
                mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "Deploying to Developement environement ${env.JOB_NAME} - Failed", 
                body: "This is an Urgent Problem ! \n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
               sh "exit 1"}    
              
            }
            }
             }
               post { 
        always {
            script{
                if( (env.BRANCH_NAME == 'Develop') && (build=="true") && (deploy=="true")&&("${USER_INPUT1}" == "Yes")&&(p2=="true")){
            mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "Developement environement  ${env.JOB_NAME} has been Updated- ", 
                body: " Please verify if every thing is working fine! \n\nhttp://192.168.1.100/devlien \n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
        }
            }
        }
              }
           }
         stage("Release") {
             when {
              expression{
                                    
    ((env.BRANCH_NAME == 'master') && ("${USER_INPUT}" == "Prod") && (p1=="true")) && (build=="true")|| ((env.BRANCH_NAME == 'master')&& ("${USER_INPUT}" == "Mirror") && (p1=="true")) &&(build=="true");
              }                     
                                }
             steps {
              catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {         
            script {
            timeout(time: 1, unit: 'MINUTES') {
                
             USER_INPUT3 = input(
                    message: "Do you want to Release  to ${USER_INPUT}- ?",
                    parameters: [
                            [$class: 'ChoiceParameterDefinition',
                             choices: ['Yes','No'].join('\n'),
                             name: 'input',
                             description: 'Chose Wise - the Stage will abort itself in 1 Minute ']
                    ])
                 if( "${USER_INPUT3}" == "Yes"){
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
            }
                if( "${USER_INPUT3}" == "No"){
                   //currentBuild.result = 'ABORTED'
                   unstable('"\033[1;33m No was Selected! \033[0m"')
                    return
    //error('Stopping early…')
                }
                try{
            if( ("${USER_INPUT}" == "Mirror") &&(p1=="true")&&(USER_INPUT3=="Yes") &&(build=="true")  ){
                sh"mvn -Pmirror clean install"
            }
                else if( ("${USER_INPUT}" == "Prod") &&(USER_INPUT3=="Yes")&& (p1=="true")&&(build=="true")){
             
               sshagent(['firas-pem']) {
    sh 'ssh -o StrictHostKeyChecking=no root@192.168.1.100 "sudo pkill -9 java;sudo rm -Rf /opt/apache-tomcat-8.5.45/webapps/ROOT*"'
 sh 'scp -o StrictHostKeyChecking=no myproject/target/*.war root@192.168.1.100:/opt/apache-tomcat-8.5.45/webapps/ROOT.war'
 sh 'ssh -o StrictHostKeyChecking=no root@192.168.1.100 "sudo chmod -R 777 /opt/apache-tomcat-8.5.45/webapps/*.war"'

}
                      sshagent(['firas-pem']) {
    sh 'ssh -o StrictHostKeyChecking=no root@192.168.1.100 "sudo rm -Rf /opt/apache-tomcat-8.5.45/webapps2/ROOT*"'
 sh 'scp -r -o StrictHostKeyChecking=no my-app/dist/my-app root@192.168.1.100:/opt/apache-tomcat-8.5.45/webapps2/ROOT'
 sh 'ssh -o StrictHostKeyChecking=no root@192.168.1.100 "sudo chmod -R 777 /opt/apache-tomcat-8.5.45/webapps2/*ROOT; sudo /opt/apache-tomcat-8.5.45/bin/catalina.sh start &"'

}
                }
                else {
                sh"echo no Release"
                }
                     } catch (Exception e) {
                release="false"
slackSend (color: '#C60800',channel:'#dashbord_backend_feedback', message: "${env.STAGE_NAME} STAGE FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'")
                mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "Releasing to ${USER_INPUT} environement ${env.JOB_NAME} - Failed", 
                body: "This is an Urgent Problem ! \n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
               sh "exit 1"}    
            }
            }
             }
              post { 
           always {
            script{
                if( ("${USER_INPUT}" == "Prod") &&(USER_INPUT3=="Yes")&& (p1=="true")&&(build=="true")&&(release=="true")&&(env.BRANCH_NAME == 'master')){
            mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "${USER_INPUT} environement  ${env.JOB_NAME} has been Updated- ", 
                body: " Please verify if every thing is working fine! \n\n http://192.168.1.100/ \n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
            }
                if( ("${USER_INPUT}" == "Mirror") &&(p1=="true")&&(USER_INPUT3=="Yes") &&(build=="true")&&(release=="true")&&(env.BRANCH_NAME == 'master')  ){
                    mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "${USER_INPUT} environement  ${env.JOB_NAME} has been Updated- ", 
                body: " Please verify if every thing is working fine! \n\n http://192.168.1.100/mirrorlien \n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
                }
            }
              }
           }
         }
                
             stage('nexus-upload') {
                            when {
                                expression{
                                    
    ((release=="true") && (env.BRANCH_NAME == 'master') && ("${USER_INPUT}" == "Prod") && (p1=="true")) && (build=="true")|| ((release=="true") && (env.BRANCH_NAME == 'master') && (currentBuild.result == 'ABORTED') &&(build=="true")&& ("${USER_INPUT}" == "Prod"));
                                    
                                }
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
            if( ("${USER_INPUT2}" == "Yes")&&(p3=="true") &&(build=="true")){
                sh"mvn -Pprod deploy"
                sh"cd my-app && npm publish"
            }
                    else{
                        sh"no nexus Uploading"
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
        always {
            script{
                if( ("${USER_INPUT2}" == "Yes")&&(p3=="true") &&(build=="true")&&(upload=="true")&&(env.BRANCH_NAME == 'master')){
            mail to: 'mhennifiras100@gmail.com', from: 'jenkinshr6@gmail.com',
                subject: "Nexus backup  ${env.JOB_NAME} has been Updated- ", 
                body: " You can check your nexus repository at : \n\nhttp://192.168.1.45:8081/ \n\nor at: \n\nhttps://nexus.hrdatabank.com/ \n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
        }
            }
        }
              }
           }
           
         }
}    
            }
         }
          stage('Clean'){     
          steps{  
              script{
  if(build=="false" || test=="false" ||  javadoc=="false" || analyse=="false" || selenium=="false" || deploy=="false" || release=="false" || upload=="false" ||backup=="false" || verif=="false" || monitor=="false"){
                       currentBuild.result = 'FAILURE'  }

 
                 
              }
                }
          }
     }
}
