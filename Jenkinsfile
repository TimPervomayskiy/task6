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
        stage('stage 3') {
          steps {
            script {
              sh "ls -l && ls -l ./dialmyappproxy && ls -l ./dma-configs"
              sh "cd ./dialmyappproxy && git status"
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
