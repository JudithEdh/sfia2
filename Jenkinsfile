pipeline{
        agent any
        stages{
            stage('Run'){
                steps{
                          withCredentials([file(credentialsId: 'key_new', variable: 'key_new'), 
                                           file(credentialsId: 'SECRET_KEY', variable: 'SECRET_KEY'), 
                                           file(credentialsId: 'DATABASE_URI', variable: 'DATABASE_URI'), 
                                           file(credentialsId: 'DB_PASSWORD', variable: 'DB_PASSWORD'),
                                          file(credentialsId: 'MYSQL_ROOT_PASSWORD', variable: 'MYSQL_ROOT_PASSWORD'), ]) {
                                sh '''
                                cd
                                rm -rf ~/key_new.pem
                                cp \$key_new ~/key_new.pem
                                pwd
                                chmod 400 key_new.pem
                                pwd
                                ls
                                ssh -o StrictHostKeyChecking=no -i "key_new.pem" ubuntu@3.9.188.81 uptime
                                
                                ssh -v -i key_new.pem ubuntu@3.9.188.81
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
                                sudo docker-compose down --rmi all
                                sudo -E MYSQL_ROOT_PASSWORD=${DB_PASSWORD} DB_PASSWORD=${DB_PASSWORD} DATABASE_URI=${DATABASE_URI} SECRET_KEY=${SECRET_KEY} docker-compose up -d --build
                                sudo docker-compose logs
                                exit
                                '''  
                   
                 
                          }

                }
            }
          }
        }
   
          

