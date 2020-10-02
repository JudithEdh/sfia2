pipeline{
        agent any
        stages{
            stage('Run'){
                steps{
                        sshagent(['ubuntu']) {
                          withCredentials([string(credentialsId: 'DATABASE_URI', variable: 'DATABASE_URI'), 
                                           string(credentialsId: 'DB_PASSWORD', variable: 'DB_PASSWORD'), 
                                           string(credentialsId: 'TEST_DATABASE_URI', variable: 'TEST_DATABASE_URI')]) {
                                sh '''
                                 ssh -o StrictHostKeyChecking=no -v ubuntu@3.9.189.120 << EOF 
                                 
                                 rm -rf ~/sfia2 
                                 if [ -d ~/sfia2 ]
                                  then
                                        rm -rf sfia2
                                  fi
                                  git clone -b ssh https://github.com/JudithEdh/sfia2  
                                  pwd
                                  cd sfia2
                                  git pull
                                  pwd
                                  
                                  sudo docker-compose logs
                                  '''  

                 
                          }
                        }
                }
            }
          }
        }
