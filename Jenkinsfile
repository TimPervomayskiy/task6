def AGENT_LABEL="agent-0"

pipeline {
    agent any
    options {
        timestamps ()
        buildDiscarder(logRotator(numToKeepStr: '100'))
    }
    parameters {
      choice(name: 'BRANCH', choices: ['master', 'dev', 'stable', 'test'], description: 'Please select branch which you want to use')
      choice(name: 'DEPLOY_MODE', choices: ['Full', 'Only Gateway', 'Only Balancer'], description: '')
      booleanParam(name: 'BUILD_ONLY', description: 'Check if you want to build image only without deployment update')
      choice(name: 'ENVIRONMENT', choices: ['development', 'production', 'production-br'], description: 'Please select cluster which you want to update')
      choice(name: 'CUSTOMER', choices: ['' ,'test', 'reserved'], description: '')
    }
    environment {
        PASS_TO_CONF_DIR = "./api/pipelines/"
        CHAT_ID="-222791277"
    }
    stages {
        stage('clean direstory') {
          steps {
            script {
              step([$class: 'WsCleanup'])
            }
          }
        }
        stage('directory preparation') {
          steps {
            dir('dialmyappproxy') {
                git branch: '$BRANCH', credentialsId: 'git_new', url: 'https://github.com/mbteswedenab/dialmyappproxy'
            }
            dir('dma-configs') {
                git branch: 'master', credentialsId: 'git_new', url: 'https://github.com/mbteswedenab/dma-configs.git'
            }
          }
        }
        stage('env preparation') {
          steps {
            script {
              sh "chmod +x ./dma-configs/api/deploy/env.sh"
              sh "./dma-configs/api/deploy/env.sh"
            }
          }
        }
        stage('run build step') {
          steps {
            script {
              def props = readProperties  file: './variables.properties'
              sh '''
                #!/bin/bash
                  cd ./dialmyappproxy
                  export GIT_COMMIT_DATE=$(git -C ./ log -1 --format=%cd)
                  export ORIGIN_BRANCH=$BRANCH
                  export GCS_FOLDER="gs://sip-updates/$BRANCH"
                  echo $GIT_COMMIT_DATE $ORIGIN_BRANCH $GCS_FOLDER
                  chmod a+x build.sh
                  ./build.sh
              '''
            }
          }
        }
      }
    post {
        always {
            script {
            sh "echo end"
       }
    }
  }
}
