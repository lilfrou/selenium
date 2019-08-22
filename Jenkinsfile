pipeline {
    agent any
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
              sh "mvn clean" 
                
        }
    }  
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
    stage('nexus'){
    steps{
nexusPublisher nexusInstanceId: 'try1', nexusRepositoryId: 'maven-releases', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: 'myproject/target/myproject-0.0.1-SNAPSHOT.war']], mavenCoordinate: [artifactId: 'seleniumparent', groupId: 'seleniumparent', packaging: 'war', version: '1.1']]]}
    post {
        always {
            step([$class: 'Publisher', reportFilenamePattern: '**/testng-results.xml'])
            
        }
}
}
