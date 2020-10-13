pipeline{
        agent any
         environment {
            app_version = 'v0'
            rollback = 'false'
        }
        stages{
            stage('Build Images'){
                steps{
                    script{
                        if (env.rollback == 'false'){
                            imagef = docker.build("judithed/sfia2-frontend", "./frontend")
                            imageb = docker.build("judithed/sfia2-backend", "./backend")
                        }
                    }
                }
            }
            stage('Tag & Push Image'){
                steps{
                    script{
                        if (env.rollback == 'false'){
                            docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials'){
                                imagef.push("${env.app_version}")
                                imageb.push("${env.app_version}")
                            }
                        }
                    }
                }
            }
            stage('Test'){
                steps{
                       sshagent(['ubuntu']) {
                         withCredentials([string(credentialsId: 'DATABASE_URI', variable: 'DATABASE_URI'), 
                                          string(credentialsId: 'DB_PASSWORD', variable: 'DB_PASSWORD'),
                                          string(credentialsId: 'hub_password', variable: 'hub_password'),
                                          string(credentialsId: 'TEST_DATABASE_URI', variable: 'TEST_DATABASE_URI')]) {
                                 
                                 
                                 sh '''
                                  ssh -o StrictHostKeyChecking=no -tt ubuntu@52.31.158.32 << EOF 
                                  cd sfia2
                                  git pull origin development
                                  docker login --username judithed --password $hub_password
                                  sudo docker-compose down sudo docker-compose down --rmi all
                                  sudo docker rmi judithed/sfia2-backend:$app_version
                                  sudo docker rmi judithed/sfia2-frontend:$app_version
                                  sudo docker pull judithed/sfia2-frontend:$app_version
                                  sudo docker pull judithed/sfia2-backend:$app_version
                                  
                                  sudo -E MYSQL_ROOT_PASSWORD=$DB_PASSWORD DB_PASSWORD=$DB_PASSWORD DATABASE_URI=$DATABASE_URI SECRET_KEY=$SECRET_KEY TEST_DATABASE_URI=$TEST_DATABASE_URI app_version=$app_version docker-compose up -d 
                                  
                                  sudo docker exec sfia2_frontend_1 pytest --cov application 
                                  sudo docker exec sfia2_backend_1 pytest --cov application
                                  sudo docker exec sfia2_frontend_1 pytest --cov application > test_frontend.txt
                                  sudo docker exec sfia2_backend_1 pytest --cov application > test_backend.txt
                                  
                                  git pull
                                  git add .
                                  git commit -am "app version $app_version"
                                  git push

                                  exit
                                 '''

                 
                         }
                        }
                }
            }
         
            stage('Deploy'){
                steps{
                         withCredentials([string(credentialsId: 'DATABASE_URI', variable: 'DATABASE_URI'), 
                                          string(credentialsId: 'DB_PASSWORD', variable: 'DB_PASSWORD'),
                                          string(credentialsId: 'hub_password', variable: 'hub_password'),
                                          string(credentialsId: 'TEST_DATABASE_URI', variable: 'TEST_DATABASE_URI')]) {
                                 
                                 
                               sh '''
                                 ssh -o StrictHostKeyChecking=no -tt jenkins@35.246.46.217 <<EOF
                                 rm -rf sfia2
                                 git clone https://github.com/JudithEdh/sfia2
                                 cd sfia2
                                 git pull
                                 kubectl create secret generic test-secret --from-literal=SECRET_KEY=$SECRET_KEY --from-literal=DATABASE_URI=$DATABASE_URI --from-literal=TEST_DATABASE_URI=$TEST_DATABASE_URI --from-literal=MYSQL_ROOT_PASSWORD=$DB_PASSWORD --from-literal=DB_PASSWORD=$DB_PASSWORD
                                 docker login --username judithed --password $hub_password
                                 sudo docker pull judithed/sfia2-frontend:$app_version
                                 sudo docker pull judithed/sfia2-backend:$app_version
                                 cd kubernetes
                                 sed -i s+judithed/sfia2-frontend:version+judithed/sfia2-frontend:$app_version+g frontend.yml
                                 sed -i s+judithed/sfia2-backend:version+judithed/sfia2-backend:$app_version+g backend.yml
                                 sed -i s+number+$app_version+g frontend.yml
                                 sed -i s+number+$app_version+g backend.yml
                                 cd ..
                                 kubectl apply -f kubernetes/
                                 kubectl get svc
                                 
                                 exit
                                 '''

                 
                         
                        }
                }
            }    
          }
        }
