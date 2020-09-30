pipeline{
        agent any
        stages{
            stage('Run'){
                steps{
                        sshagent(['ubuntu']) {
                          withCredentials([string(credentialsId: 'DATABASE_URI', variable: 'DATABASE_URI'), 
                                           string(credentialsId: 'DB_PASSWORD', variable: 'DB_PASSWORD')]) {
                                sh '''
                                 ssh -o StrictHostKeyChecking=no -v ubuntu@35.178.96.209 << EOF 
                                 
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
                                  sudo docker-compose down --rmi all
                                  sudo -E MYSQL_ROOT_PASSWORD=$DB_PASSWORD DB_PASSWORD=$DB_PASSWORD DATABASE_URI=$DATABASE_URI SECRET_KEY=$DB_PASSWORD docker-compose up -d --build
                                  sudo docker-compose logs
                                  EOF
                                  '''  
                   
                 
                          }
                        }
                }
            }
          }
        }
   
          

