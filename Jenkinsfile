pipeline {
    agent any

    stages {
        stage('Prepare Environment') {
            steps {
                script {
                    docker.image('maven:3-alpine').pull()
                    docker.image('php:7.2-apache').pull()
                }
            }
        }
        stage('Integration UI Test') {
            parallel {
                stage('Deploy') {
                    agent {
                        docker {
                            image 'php:7.2-apache'
                            args '-u root:root'
                        }
                    }
                    steps {
                        sh 'docker run -d -p 80:80 --name my-apache-php-app -v /var/jenkins_home/workspace/jenkins-php-selenium-test/src:/var/www/html php:7.2-apache'
                        sh './jenkins/scripts/deploy.sh'
                    }
                }
                stage('Headless Browser Test') {
                    agent {
                        docker {
                            image 'maven:3-alpine'
                            args '-u root:root -v /var/jenkins_home/.m2:/root/.m2'
                        }
                    }
                    steps {
                        sh 'mvn -B -DskipTests clean package'
                    }
                }
            }
        }
    }
}
