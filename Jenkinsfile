pipeline {
    agent any
    stages {
      stage('print all env') {
        steps {
          sh 'printenv'
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
//testing
