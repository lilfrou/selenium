stage('Build') {
    parallel([
        build: {
            node('linux') {
                sh 'make'
                stash includes: 'pkg/**/*', name: 'build'
            }
        },
        docs: {
            build job: 'docs', wait: false
        },
        staticAnalysis: {
            build job: 'staticAnalysis', wait: false
        }
    ])
}

testSuites = [ 'suite1', 'suite2', 'suite3' ]

stage('Test') {
    testSteps = [:]
    for (suite in testSuites) {
        testSteps[suite] = {
            node('linux') {
                unstash 'build'
                sh "run_tests $suite"
                stash includes: 'test_results/**/*.xml', name: "test-$suite"
            }
        }
    }
    parallel(testSteps)
}

// method to lookup the docs and staticAnalysis jobs we started and see if they're done
@NonCPS
def findSomeBuild(jobName)
    // do Jenkins groovy stuff
    return correctBuildNumber || null
end

stage('Archive') {
    unstash 'build'

    def docsBuildNumber = null    
    waitUntil {
        docsBuildNumber = findSomeBuild('docs')
    }
    
    def staticAnalysisBuildNumber = null
    waitUntil {
        staticAnalysisBuildNumber = findSomeBuild('staticAnalysis')
    }
    
    step([$class: 'CopyArtifact', filter: 'pkg/**/*', projectName: 'docs', selector: [$class: 'SpecificBuildSelector', buildNumber: docsBuildNumber]])
    step([$class: 'CopyArtifact', filter: 'pkg/**/*', projectName: 'staticAnalysis', selector: [$class: 'SpecificBuildSelector', buildNumber: staticAnalysisBuildNumber]])

    unstash 'documentation'
    unstash 'static_analysis'
    for (suite in testSuites) {
        unstash "test-$suite"
    }
    archive 'pkg/**/*'
    junit 'test_results/**/*.xml'
}
