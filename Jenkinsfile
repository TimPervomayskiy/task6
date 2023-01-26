def AGENT_LABEL="agent-0"

pipeline {
    agent any
    options {
        timestamps ()
        buildDiscarder(logRotator(numToKeepStr: '100'))
    }
    parameters {
      choice(name: 'BRANCH', choices: ['master'], description: 'Please select branch which you want to use')
      booleanParam(name: 'BUILD_ONLY', description: 'Check if you want to build image only without deployment update')
      choice(name: 'ENVIRONMENT', choices: ['development', 'production', 'production-br'], description: 'Please select cluster which you want to update')
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
            dir('dma-webrtc-proxy') {
                git branch: '$BRANCH', credentialsId: 'git_new', url: 'https://github.com/mbteswedenab/dma-webrtc-proxy.git'
            }
            dir('dma-configs') {
                git branch: 'master', credentialsId: 'git_new', url: 'https://github.com/mbteswedenab/dma-configs.git'
            }
          }
        }
        stage('check') {
          steps {
            script {
              sh "ls -l && ls -l ./dma-webrtc-proxy && ls -l dma-webrtc-proxy"
              sh "cd ./dma-webrtc-proxy/ && git status"
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
                  mkdir output
              '''
            }
          }
        }
        stage('test artif') {
          steps {
            script {
              sh "touch dialmyappproxy/output/test_artifact.txt"
            }
          }
        }
      }
      post {
        always {
          archiveArtifacts artifacts: 'dialmyappproxy/output/**', fingerprint: true
        }
    }
}
