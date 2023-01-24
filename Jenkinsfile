def AGENT_LABEL="agent-0"

pipeline {
    agent any
    options {
        timestamps ()
        buildDiscarder(logRotator(numToKeepStr: '100'))
    }
    environment {
        PASS_TO_CONF_DIR = "./api/pipelines/"
        CHAT_ID="-222791277"
    }
    stages {
        stage('create folders') {
          steps {
            dir('dialmyappproxy') {
                git credentialsId: 'git_new', url: 'https://github.com/mbteswedenab/dialmyappproxy.git'
            }
            dir('dma-configs') {
                git credentialsId: 'git_new', url: 'https://github.com/mbteswedenab/dma-configs.git'
            }
          }
        }
        stage('stage 2') {
          steps {
            script {
              sh "ls -l && ls -l ./dialmyappproxy && ls -l ./dma-configs"
            }
          }
        }
        stage('stage 4') {
          steps {
            script {
            sh "ls -l && ls -l .."
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
