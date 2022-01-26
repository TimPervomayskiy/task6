properties([pipelineTriggers([githubPush()])])

pipeline {
    agent any
    stages {
      stage('checkoput') {
        steps {
         checkout(
     [
     $class: 'GitSCM',
     branches: [[name: 'master']],
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
        }
      }
  }
    post {
        always {
            script {
        //    step([$class: 'WsCleanup'])
       }
    }
  }
}
//test_merge
