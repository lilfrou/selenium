pipeline {
     agent any

    stages {
           
        stage("build and deploy on Windows and Linux") {
            parallel {
                stage("windows") {
                     agent any
                    stages {
                        stage("build") {
                            steps {
                                sh"echo 1"
                            }
                        }
                        stage("deploy") {
                           
                            steps {
                                sh"echo 1"
                            }
                        }
                    }
                }
                stage("linux") {
                     agent any
                    stages {
                        stage("build") {
                            steps {
                                sh"echo 1"
                            }
                        }
                        stage("deploy") {
                            
                             steps {
                                sh"echo 1"
                            }
                        }
                              stage("build1") {
                            steps {
                                sh"echo 1"
                            }
                        }
                        stage("deploy1") {
                            
                             steps {
                                sh"echo 1"
                            }
                        }
                    }
                   
                }
              
            }
              stage('Run Tests') {
            parallel {
                stage('Test On Windows') {
                  
                    steps {
                       sh "echo windows"
                    }
                   
                }
                stage('Test On Linux') {
                   
                    steps {
                      sh "echo windows"
                    }
                    
                }
            }
        }  
        }
    }
}
