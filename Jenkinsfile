properties([pipelineTriggers([githubPush()])])

pipeline {
    agent any
    stages {
      stage('print all env') {
        steps {
          sh 'printenv'
        }
      }
      stage('Checkout SCM') {
    steps {
      checkout([
        $class: 'GitSCM',
        branches: [[name: 'develop']],
        userRemoteConfigs: [[
          url: 'git@github.com:TimPervomayskiy/task6.git',
          credentialsId: '',
        ]]
       ])
     }
  }
    }
    post {
        always {
            script {
            step([$class: 'WsCleanup'])
       }
    }
}
  }
//testing
