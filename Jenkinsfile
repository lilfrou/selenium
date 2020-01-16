pipeline {
    agent any
    tools {
        maven 'Maven'
        jdk 'jdk'
    }
     stages {
       /** stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }*/
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
               sh'mvn javadoc:aggregate'
                 
         
                
        }
    } 
         sshagent(['firas-pem']) {
      sh 'scp -o StrictHostKeyChecking=no myproject/target/*.war ec2-user@xxx.xx.xx.xxx:/opt/tomcat8/webapps/'
    
}
     /*stage('pub') {
         steps{
    publishHTML (target: [
       allowMissing: false,
       alwaysLinkToLastBuild: false,
       keepAll: true,
       reportDir: 'target/site/apidocs',
       reportFiles: 'index.html',
       reportName: "javadoc"
     ])
         }
    }*/
}    

}
    
    
    /*
         stage('selenium') {
            steps {
                sh "mvn test -DsuiteXmlFile=testng.xml"
              sh "mvn cobertura:cobertura" 
            }   
             post {

  always {
    cobertura coberturaReportFile: 'target/site/cobertura/coverage.xml'
    }
}
      } 
    stage('sonar') {
        steps{
              sh 'mvn verify sonar:sonar\
 -Dsonar.projectKey=lilfrou_selenium\
 -Dsonar.organization=lilfrou-github\
 -Dsonar.host.url=https://sonarcloud.io\
 -Dsonar.login=aea4ae9047ac47d6e0b367b0a12c8d239bbaa1da\
 -Dsonar.java.libraries=target'

    }
    }
    stage('sonar12') {
        steps{
    sh 'mvn verify sonar:sonar\
 -Dsonar.projectKey=lilfrou_selenium\
 -Dsonar.organization=lilfrou-github\
 -Dsonar.host.url=https://sonarcloud.io\
 -Dsonar.login=aea4ae9047ac47d6e0b367b0a12c8d239bbaa1da\
 -Dsonar.branch.name=sonar\
 -Dsonar.branch.target=master\
 -Dsonar.java.libraries=target'
        }
    }
    stage('pull request #20'){ 
         steps{
           sh 'mvn verify sonar:sonar  \
                -Dsonar.projectKey=lilfrou_selenium\
                -Dsonar.organization=lilfrou-github\
                -Dsonar.host.url=https://sonarcloud.io \
                -Dsonar.login=aea4ae9047ac47d6e0b367b0a12c8d239bbaa1da\
                -Dsonar.pullrequest.key=5\
                -Dsonar.pullrequest.branch=sonar\
                -Dsonar.pullrequest.base=master\
                -Dsonar.pullrequest.provider=GitHub\
                -Dsonar.pullrequest.github.repository=lilfrou/selenium\
                -Dsonar.java.libraries=target'
         }
    }
    stage('nexus'){
    steps{
nexusPublisher nexusInstanceId: 'try1', nexusRepositoryId: 'maven-releases', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: 'myproject/target/myproject-0.0.1-SNAPSHOT.war']], mavenCoordinate: [artifactId: 'seleniumparent', groupId: 'seleniumparent', packaging: 'war', version: '1.1']]]}
    }
}
        post {
        always {*/
          //  step([$class: 'Publisher', reportFilenamePattern: '**/testng-results.xml'])
      /*      
        }
}
}
*/
