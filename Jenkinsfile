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
                                cd /home/ubuntu/web-app/sfia2
                                git pull
                              
                                '''
                   
                 
                 

                }
            }
          }
        }
   }
          

