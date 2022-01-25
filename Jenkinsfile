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
        branches: [[name: 'master']],
        userRemoteConfigs: [[
          url: 'https://github.com/TimPervomayskiy/task6.git',
          credentialsId: 'git_tim',
        ]]
       ])
     }
  }
  stages {
    stage('git merge') {
      steps {
        script {
        withCredentials([gitUsernamePassword(credentialsId: 'git_tim', gitToolName: 'git')]) {
         sh 'git checkout master'
         sh 'git merge develop'
         sh 'git add .'
         sh """git commit -m 'merge from $JOB_NAME' """
         sh 'git push origin master'
          }
        }
      }
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
