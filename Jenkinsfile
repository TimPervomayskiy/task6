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
        branches: [[name: '*']],
        userRemoteConfigs: [[
          url: 'https://github.com/TimPervomayskiy/task6.git',
          credentialsId: 'git_tim',
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
