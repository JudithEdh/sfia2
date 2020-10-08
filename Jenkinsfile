pipeline{
        agent any
         environment {
            app_version = 'v1'
            rollback = 'false'
        }
        stages{
            stage('Build Images'){
                steps{
                    script{
                        if (env.rollback == 'false'){
                            imagef = docker.build("judithed/sfia2-frontend", "./frontend")
                            imageb = docker.build("judithed/sfia2-backend", "./backend")
                        }
                    }
                }
            }
            stage('Tag & Push Image'){
                steps{
                    script{
                        if (env.rollback == 'false'){
                            docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials'){
                                imagef.push("${env.app_version}")
                                imageb.push("${env.app_version}")
                            }
                        }
                    }
                }
            }
            stage('Test'){
                steps{
                        sshagent(['ubuntu']) {
                         withCredentials([string(credentialsId: 'DATABASE_URI', variable: 'DATABASE_URI'), 
                                          string(credentialsId: 'DB_PASSWORD', variable: 'DB_PASSWORD'),
                                          string(credentialsId: 'TEST_DATABASE_URI', variable: 'TEST_DATABASE_URI')]) {
                                 
                                 
                                 sh '''
                                 DOCKER_HOST="ssh://-o StrictHostKeyChecking=no -tt ubuntu@35.177.140.168" -E MYSQL_ROOT_PASSWORD=$DB_PASSWORD DB_PASSWORD=$DB_PASSWORD DATABASE_URI=$DATABASE_URI SECRET_KEY=$SECRET_KEY TEST_DATABASE_URI=$TEST_DATABASE_URI docker-compose pull && docker-compose up -d
                                 '''

                 
                          }
                        }
                }
            }
                
                
          }
        }
