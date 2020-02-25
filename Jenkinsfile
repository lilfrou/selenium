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
 stage("build and deploy on Windows and Linux21") {               
 parallel {
                stage("windows2") {
                     agent any
                    
                        stage("build2") {
                            steps {
                                sh"echo 1"
                            }
                        }
                        stage("deploy2") {
                           
                            steps {
                                sh"echo 1"
                            }
                        }
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
        }
    }
}
