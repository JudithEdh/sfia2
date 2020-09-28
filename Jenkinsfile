pipeline{
        agent any
            environment {
                    SECRET_KEY    =$SECRET_KEY
                    DATABASE_URI    =$DATABASE_URI
                    DB_PASSWORD    =$DB_PASSWORD
                    MYSQL_ROOT_PASSWORD    =$MYSQL_ROOT_PASSWORD
        
                                }
        stages{
            stage('Run'){
                steps{
                 sshagent(['ubuntu']) {
                         sh 'ssh -o StrictHostKeyChecking=no ubuntu@18.134.12.28 uptime'
                                sh '''
                                ssh -v ubuntu@18.134.12.28<<-'ENDSSH'
                                #!/bin/bash
                                 DIRECTORY=~/sfia2 
                                 rm -rf DIRECTORY
                                 if [ -d ~/sfia2 ]
                                  then
                                        rm -rf sfia2
                                  fi
                                  FILE=/sfia2
                                  sudo apt-get install git
                                  if [ -d "$FILE" ]
                                        then
                                         echo exists
                                        else 
                                         git clone -b ssh https://github.com/JudithEdh/sfia2  
                                  fi 
                                pwd
                                cd ~/sfia2
                                git pull
                                sudo apt update
                                curl https://get.docker.com | sudo bash
                                sudo usermod -aG docker $(whoami)
                                sudo apt install -y curl jq
                                version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r '.tag_name')
                                sudo curl -L "https://github.com/docker/compose/releases/download/${version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
                                sudo chmod +x /usr/local/bin/docker-compose
                                pwd
                                export SECRET_KEY
                                export DATABASE_URI
                                export DB_PASSWORD
                                export MYSQL_ROOT_PASSWORD
                                sudo docker-compose down --rmi all
                                sudo -E MYSQL_ROOT_PASSWORD=${DB_PASSWORD} DB_PASSWORD=${DB_PASSWORD} DATABASE_URI=${DATABASE_URI} SECRET_KEY=${SECRET_KEY} docker-compose pull && sudo -E MYSQL_ROOT_PASSWORD=${DB_PASSWORD} DB_PASSWORD=${DB_PASSWORD} DATABASE_URI=${DATABASE_URI} SECRET_KEY=${SECRET_KEY} docker-compose up -d --build
                                sudo docker-compose logs
                                '''  
                   
                 
                 

                }
            }
          }
        }
   }
          

