pipeline{
        agent any
        stages{
            stage('Run'){
                steps{
                 sshagent(['cb38f8ec-2d0a-4696-bd26-8e23756d0756']) {
                   sh '''
                   ssh ubuntu@18.134.12.28
                  DIRECTORY=~/web-app  
                  rm -rf DIRECTORY
                  if [ -d ~/web-app ]
                  then
                      rm -rf $DIRECTORY
                  else 
                    mkdir $DIRECTORY
                    cd $DIRECTORY
                  fi
                  FILE=/home/jenkins/.jenkins/workspace/web-app/sfia2
                  sudo apt-get install git                
                  if [ -d "$FILE" ]
                  then
                    echo exists
                  else 
                    git clone -b ssh https://github.com/JudithEdh/sfia2  
                  fi 
                  pwd
                  cd /sfia
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
          

