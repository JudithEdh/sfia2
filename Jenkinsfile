pipeline{
        agent any
        stages{
            stage('Run & Test'){
                steps{
                        sshagent(['ubuntu']) {
                         withCredentials([string(credentialsId: 'DATABASE_URI', variable: 'DATABASE_URI'), 
                                          string(credentialsId: 'DB_PASSWORD', variable: 'DB_PASSWORD'),
                                          string(credentialsId: 'TEST_DATABASE_URI', variable: 'TEST_DATABASE_URI')]) {
                                sh '''
                                 ssh -o StrictHostKeyChecking=no -tt ubuntu@18.134.10.201 << EOF 
                                 
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
                                  sudo -E MYSQL_ROOT_PASSWORD=$DB_PASSWORD DB_PASSWORD=$DB_PASSWORD DATABASE_URI=$DATABASE_URI SECRET_KEY=$SECRET_KEY TEST_DATABASE_URI=$TEST_DATABASE_URI docker-compose up -d --build
                                  sudo docker exec sfia2_frontend_1 pytest --cov application 
                                  sudo docker exec sfia2_backend_1 pytest --cov application
                                  sudo docker exec sfia2_frontend_1 pytest --cov application > test_frontend.txt
                                  sudo docker exec sfia2_backend_1 pytest --cov application > test_backend.txt
                                  exit
                                  '''  

                 
                          }
                        }
                }
            }
                
                
          }
        }
