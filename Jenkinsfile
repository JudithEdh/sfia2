pipeline{
        agent any
        stages{
            stage('Run'){
                steps{
                 sshagent(['ubuntu']) {
                         sh 'ssh -o StrictHostKeyChecking=no ubuntu@18.134.12.28 uptime'
                                sh '''
                                ssh -v ubuntu@18.134.12.28<<-'ENDSSH'
                                #!/bin/bash
                                 DIRECTORY=~/web-app  
                                 rm -rf DIRECTORY
                                 if [ -d ~/web-app ]
                                  then
                                        rm -rf $DIRECTORY
                                  else 
                                        mkdir $DIRECTORY
                                  cd $DIRECTORY
                                  fi
                                  FILE=/home/ubuntu/web-app/sfia2
                                  sudo apt-get install git
                                  if [ -d "$FILE" ]
                                        then
                                         echo exists
                                        else 
                                         git clone -b ssh https://github.com/JudithEdh/sfia2  
                                  fi 
                                  pwd
                                cd /home/ubuntu/web-app/sfia2
                                git pull
                              
                                '''
                   
                 
                 

                }
            }
          }
        }
   }
          

