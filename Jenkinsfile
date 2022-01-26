properties([pipelineTriggers([githubPush()])])

pipeline {
    agent any
    stages {
    stage('test for check merge') {
      steps {
        sh 'cat ./Jenkinsfile'
      }
    }
      stage('checkout') {
        steps {
         checkout(
     [
     $class: 'GitSCM',
     branches: [[name: '*']],
     userRemoteConfigs: [[
       url: 'https://github.com/TimPervomayskiy/task6.git',
       credentialsId: 'git_tim',
     ]],
         extensions: [
             [
                 $class: "PreBuildMerge",
                 options: [
                     mergeTarget: "develop",
                     fastForwardMode: "FF",
                     mergeRemote: "origin",
                     mergeStrategy: "RECURSIVE_THEIRS"
                 ],
             ],
            [
                $class: 'UserIdentity',
                email: 'test@test.com',
                name: 'clown'
            ],
         ],
     ]
 )
        }
      }
      stage('print all env') {
        steps {
          sh 'printenv'
          sh 'cat ./Jenkinsfile'
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
