def AGENT_LABEL="agent-0"

pipeline {
    agent any
    options {
        timestamps ()
        buildDiscarder(logRotator(numToKeepStr: '100'))
    }
    parameters {
      choice(name: 'BRANCH', choices: ['master', 'dev', 'stable', 'test'], description: 'Please select branch which you want to use')
    environment {
        PASS_TO_CONF_DIR = "api/pipelines/sip/"
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
                git branch: '$BRANCH', credentialsId: 'e8f03bab-9bbb-4d52-90d9-face976d480d', url: 'git@github.com:mbteswedenab/dialmyappproxy.git'
            }
            dir('dma-configs') {
                git branch: 'master', credentialsId: 'e8f03bab-9bbb-4d52-90d9-face976d480d', url: 'git@github.com:mbteswedenab/dma-configs.git'
            }
          }
        }
        stage('check') {
          steps {
            script {
              if (binding.variables.containsKey('BRANCH')) {
                  ORIGIN_BRANCH = binding.variables.get('BRANCH').replace('refs/heads', 'origin')
                  return [
                       ORIGIN_BRANCH: ORIGIN_BRANCH,
                       GCS_FOLDER: 'gs://sip-updates/' + ORIGIN_BRANCH,
                       ]
                  println ORIGIN_BRANCH
              }
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

              '''
            }
          }
        }

      }
      post {
        always {
          sh "echo test"
        }
    }
}
