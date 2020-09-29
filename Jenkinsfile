pipeline{
        agent any
        stages{
            stage('Run'){
                steps{
                        sshagent(['ubuntu']) {
                          withCredentials([string(credentialsId: 'DATABASE_URI', variable: 'DATABASE_URI'), 
                                           string(credentialsId: 'DB_PASSWORD', variable: 'DB_PASSWORD')]) {
                                sh '''
                                 ssh -o StrictHostKeyChecking=no -v ubuntu@18.130.103.218 << EOF 
                                 sudo apt update
                                 udo apt-get install git
                                 curl https://get.docker.com | sudo bash
                                 sudo usermod -aG docker $(whoami)
                                 sudo apt install -y curl jq
                                 version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r '.tag_name')
                                 sudo curl -L "https://github.com/docker/compose/releases/download/${version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
                                 sudo chmod +x /usr/local/bin/docker-compose
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
   
          

