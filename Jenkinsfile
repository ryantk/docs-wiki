pipeline {
  agent {
    docker {
      image 'ruby:2.4.1'
    }
    
  }
  stages {
    stage('Build') {
      steps {
        sh 'echo "Build"'
      }
    }
    stage('Test') {
      steps {
        sh 'echo "Test"'
      }
    }
  }
}