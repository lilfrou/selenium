def test = [:]

test["a"] = {
    stage ("a") {
        stage ("ab") {
            sh "echo stage abc"
        }
        stage ("xyz") {
            sh "echo stage xyz"
        }
    }
}

test["b"] = {
    stage ("b") {
        stage ("bb") {
            sh "echo stage bb"
        }
        stage ("bxz") {
            sh "echo stagebxyz"
        }
    }
}
node {
   //stage 'start'
   parallel test
   stage ('middle') {
       sh "echo middle"
   }
   
}
node() {
  stage('Build') {
    println 'I prepare the build for the parallel steps'
  }

  stage('Test') {
   parallel (
 "win7-vs2012" : { stage("checkout") { }; stage("build") { }; stage("test") { } },
 "win10-vs2015" : { stage("checkout") { }; stage("build") { }; stage("test") { }},
 "linux-gcc5" : { stage("checkout") { }; stage("build") { }; stage("test") { } }
)
  }
}
