pipeline {
  agent {
    docker {
      image 'ruby:2.4.1'
    }
    
  }
  stages {
    stage('Build') {
      steps {
        sh 'ruby -e "puts \'Build Stage\'"'
      }
    }
    stage('Test') {
      steps {
        sh 'ruby -e "puts \'Test!\'"'
      }
    }
  }
}