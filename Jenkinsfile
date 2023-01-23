pipeline {
    agent any
    parameters {
        booleanParam(name: 'NGINX_ONLY', description: 'Check if you want just recreate Nginx pods without stopping traffic.')
        gitParameter branchFilter: 'origin/(.*)', defaultValue: 'master', name: 'BRANCH', type: 'PT_BRANCH', description: 'Please select branch which you want to use'
        }
    stages {
        stage('stage with node-js-15') {
          steps {
            sh "echo $BRANCH && ls -l"
          }
        }
        stage('stage 2') {
          steps {
            git credentialsId: 'git_new', url: 'https://github.com/Zhdanovich98/gdown.git'
            script {
            sh "echo $BRANCH && ls -l"
            }
          }
        }
        stage('stage 3') {
          steps {
            git credentialsId: 'git_new', url: 'https://github.com/Zhdanovich98/simple-nodejs-server.git'
            script {
            sh "echo $BRANCH && ls -l"
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
}
