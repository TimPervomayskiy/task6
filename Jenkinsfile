pipeline {
    agent any
    parameters {
        booleanParam(name: 'NGINX_ONLY', description: 'Check if you want just recreate Nginx pods without stopping traffic.')
        gitParameter branchFilter: 'origin/(.*)', defaultValue: 'master', name: 'BRANCH', type: 'PT_BRANCH', description: 'Please select branch which you want to use'
        }
    stages {
        stage('stage 1') {
          steps {
            sh "echo $BRANCH && ls -l"
          }
        }
        stage('stage 2') {
          steps {
            script {
              dir('gdown') {
                git credentialsId: 'git_new', url: 'https://github.com/Zhdanovich98/gdown.git'
            }
            dir('simple-nodejs-server.git') {
              git credentialsId: 'git_new', url: 'https://github.com/Zhdanovich98/simple-nodejs-server.git'
          }
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
