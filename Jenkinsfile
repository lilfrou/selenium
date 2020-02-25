pipeline {
    agent none

    stages {
        stage("build and deploy on Windows and Linux") {
            parallel {
                stage("windows") {
                    agent none
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
                    agent none
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
            }
        }
    }
}
