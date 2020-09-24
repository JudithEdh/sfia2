pipeline{
        agent any
        stages{
            stage('Make Directory'){
                steps{
                  sh '''
                  #! /bin/bash
                  DIRECTORY=~/web-app  
                  rm -rf DIRECTORY
                  if [ -d ~/web-app ]
                  then
                      rm -rf $DIRECTORY
                  else 
                    mkdir $DIRECTORY
                    cd $DIRECTORY
                  fi          
                  '''
                }
            }        
            stage('Clone Repo if it does not exist'){
                steps{
                  sh '''
                  DIRECTORY=~/jenkins-pipeline-exercise  
                  FILE=/home/jenkins/.jenkins/workspace/web-app/sfia2
                  sudo apt-get install git                
                  if [ -d "$FILE" ]
                  then
                    echo exists
                  else 
                    git clone -b practice https://github.com/JudithEdh/sfia2  
                  fi 
                  cd $FILE
                  git pull
                  '''
                }
            }
            stage('Install Docker and Docker-Compose'){
                steps{
                  sh '''
                  sudo apt update
                  curl https://get.docker.com | sudo bash
                  sudo usermod -aG docker $(whoami)
                  sudo apt install -y curl jq
                  version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r '.tag_name')
                  sudo curl -L "https://github.com/docker/compose/releases/download/${version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
                  sudo chmod +x /usr/local/bin/docker-compose
                  '''
                }
              }
            stage('Deploy the application'){
                steps{
                  sh ''' 
                  pwd
                  export SECRET_KEY
                  export DATABASE_URI
                  export DB_PASSWORD
                  export MYSQL_ROOT_PASSWORD
                  sudo -E MYSQL_ROOT_PASSWORD=${DB_PASSWORD} DB_PASSWORD=${DB_PASSWORD} DATABASE_URI=${DATABASE_URI} SECRET_KEY=${SECRET_KEY} docker-compose pull && sudo -E MYSQL_ROOT_PASSWORD=${DB_PASSWORD} DB_PASSWORD=${DB_PASSWORD} DATABASE_URI=${DATABASE_URI} SECRET_KEY=${SECRET_KEY} docker-compose up -d --build
                  sudo docker-compose logs
                  '''  
                }
            }
        }    
}
