def AGENT_LABEL="agent-0"

pipeline {
    agent any
    options {
        timestamps ()
        buildDiscarder(logRotator(numToKeepStr: '100'))
    }

    parameters {
      choice(name: 'SERVICE_NAME', choices: ['nginx', 'nginx-ivr','cdn','dma-site','ga','proxy',], description: 'Please select pods which you want to update')
      listGitBranches(
        branchFilter: 'refs/heads.*/(.*)',
        defaultValue: '',
        sortMode: 'ASCENDING_SMART',
        name: 'CONFIGS_BRANCH',
        type: 'BRANCH',
        remoteURL: 'https://github.com/mbteswedenab/dma-configs.git',
        credentialsId: 'git_new')
      choice(name: 'CUSTOMER', choices: ['telcel', 'claro', 'tim', 'test', 'avon'], description: 'Please select customer for which you want deploy build')
      choice(name: 'ENVIRONMENT', choices: ['development', 'production', 'production-br', 'tim'], description: 'Please select cluster which you want to update')
      string(name: 'USE_IMAGE', defaultValue: '', description: 'Specify image number which you want to use for deploy. So if you want use this image gcr.io/callmyapp/frontier-app:v379 you should enter only 379. Should be blank if u want build a new image.')
      booleanParam(name: 'BUILD_ONLY', description: 'Check if you want to build container only without deployment update')
    }
    environment {
        PASS_TO_CONF_DIR = "api/pipelines/sip"
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
            dir('dma-configs') {
                git branch: 'master', credentialsId: 'e8f03bab-9bbb-4d52-90d9-face976d480d', url: 'git@github.com:mbteswedenab/dma-configs.git'
            }
          }
        }
        stage('env/configs preparation') {
          steps {
            script {
                sh "cat ./dma-configs/$PASS_TO_CONF_DIR/Build_and_deploy_DMA_sip_Jenkinsfile"
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
