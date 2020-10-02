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
                                  sudo docker-compose down --rmi all
                                  sudo -E MYSQL_ROOT_PASSWORD=passord DB_PASSWORD=password DATABASE_URI='mysql+pymysql://admin:password@database-1.ccy3kij8pgjy.eu-west-2.rds.amazonaws.com:3306/users' SECRET_KEY=password TEST_DATABASE_URI='mysql+pymysql://admin:password@test-database.ccy3kij8pgjy.eu-west-2.rds.amazonaws.com:3306/testdb' docker-compose up -d --build
                                  sudo docker-compose logs
                                  '''  

                 
                          }
                        }
                }
            }
          }
        }
