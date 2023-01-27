def AGENT_LABEL="agent-0"

pipeline {
    agent any
    options {
        timestamps ()
        buildDiscarder(logRotator(numToKeepStr: '100'))
    }
    parameters {
      choice(name: 'SERVICE_NAME', choices: ['frontier', 'frontier-cache', 'frontier-analytic', 'frontier-analytic-reporting', 'frontier-analytic-processing', 'frontier-ivr',
      'frontier-sip', 'frontier-sb', 'frontier-campaigns', 'frontier-pa', 'frontier-pilot', 'frontier-pg', 'frontier-clickhouse', 'frontier-proxy', 'frontier-tim',
      'frontier-chat', 'frontier-customization'], description: 'Please select pods which you want to update')
      choice(name: 'CUSTOMER', choices: ['telcel', 'claro', 'tim', 'test'], description: 'Please select customer for which you want deploy build')
      choice(name: 'ENVIRONMENT', choices: ['development', 'production', 'production-br', 'tim'], description: 'Please select cluster which you want to update')
      string(name: 'USE_IMAGE', defaultValue: '', description: 'Specify image number which you want to use for deploy. So if you want use this image gcr.io/callmyapp/frontier-app:v379 you should enter only 379. Should be blank if u want build a new image.')
      booleanParam(name: 'DELETE_DEPLOYMENT', description: 'Check if you want to delete all service pods before new deployment')
      booleanParam(name: 'BUILD_ONLY', description: 'Check if you want to build container only without deployment update')
      booleanParam(name: 'BUILD_FRONTEND', description: 'Check if you want to rebuild UI')
      listGitBranches(
        branchFilter: 'refs/heads.*/(.*)',
        defaultValue: '',
        sortMode: 'ASCENDING_SMART',
        name: 'FRONTIER_BRANCH',
        type: 'BRANCH',
        remoteURL: 'https://github.com/mbteswedenab/lucy-coil-server.git',
        credentialsId: 'git_new')
      listGitBranches(
        branchFilter: 'refs/heads.*/(.*)',
        defaultValue: '',
        sortMode: 'ASCENDING_SMART',
        name: 'CONFIGS_BRANCH',
        type: 'BRANCH',
        remoteURL: 'https://github.com/mbteswedenab/dma-configs.git',
        credentialsId: 'git_new')
    }
    environment {
        PASS_TO_CONF_DIR = "api/pipelines/sip/"
        CHAT_ID="-222791277"
    }
    stages {
        stage('test direstory') {
          steps {
            script {
              sh "bash ./check_js.sh"
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
