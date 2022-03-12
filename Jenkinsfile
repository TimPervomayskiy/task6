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
  stage('print message') {
    steps {
      script {
        if [[ "$GIT_BRANCH" == "develop" ]]; then
          echo "I’m the best developer ever"
        elif [[ "$GIT_BRANCH" == "master" ]]; then
          echo "I’m the best DevOps ever"
        else
          echo "fail" $GIT_BRANCH
        fi
      }
    }
  }
}    post {
        always {
            script {
            emailext attachLog: true, body: '*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} More info at: ${env.BUILD_URL}', recipientProviders: [developers(), culprits(), upstreamDevelopers()], subject: '$JOB_NAME', to: 'zhdanovich.ilya98@gmail.com'
            step([$class: 'WsCleanup'])
       }
    }
  }
}
//test_merge1
