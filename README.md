# QAC SFIA 2 Project
## Introduction
The purpose of the project was to deploy a given application through a continuous integration pipeline using all the concepts and skills acquired in the second part of the training in QA academy 
## Table of Contents
- [Requirements](#requirements)
- [MOSCOW approach](#moscow-approach)
- [Planning](#planning)
- [Docker and docker compose](#docker-and-docker-compose)
- [Risk assessment](#risk-assessment)
- [Jenkins pipeline](#jenkins-pipeline)
- [Ansible](#ansible)
- [Terraform](#terraform)
- [Kubernetes](#kubernetes)
- [Summary of environment configuration](#summary-of-environment-configuration)
- [Final Product](#final-product)
- [Future work](#future-work)
- [Summary](#summary)
## Requirements
The requirements are listed below:
- Kanban Board: Jira 
- Version Control: Git
- CI Server: Jenkins
- Configuration Management: Ansible
- Cloud Server: AWS EC2
- Database Server: AWS RDS
- Containerisation: Docker
- Reverse Proxy: NGINX
- Orchestration Tool: Kubernetes
- Infrastructure Management: Terraform
## MOSCOW approach

The MOSCOW approach was followed to make sure that the essential features of the app were prioritised and to ensure the creation of a fully functional product that meets all the requirements.
- #### Must Have
1. Jenkins must be configured on a virtual machine through Ansible
2. The 2 databases (for testing and deployment) and the vm where Jenkins is running must be created through Terraform
3. The testing of the application must be performed every time a change is made on the code
4. The app must be deployed on Kubernetes
5. NGINX must be used to reverse proxy
- #### Should Have
1. Ability to roll back to a previous version of the application
- #### Won't have
1. Ability to set up all the tools needed (including a pipeline) with a few simple commands

## Planning
The planning of the project was essential in order to meet the MVP (Minimum Viable Product). The project tracking tool used was a Jira board which allows to produce epics which have tasks related to them ([Jira Board](https://judithedh.atlassian.net/secure/RapidBoard.jspa?rapidView=3&projectKey=QSP&selectedIssue=QSP-29)).
The picture below shows the steps that were followed to ensure a smooth delivery.

![Epics](https://i.imgur.com/4imH0Vl.png)

The order chosen was not random. 
In the first sprint, the aim was to deploy the application through docker and docker-compose.
Next, the plan was to run the application through a jenkins pipeline.
The following sprint ensured that the virtual machines and the databases instances were Amazon Web Services.
The next steps were to automate the creation and configuration of the instances used through Terraform and Ansible.
And finally, the application was configured to run on a kubernetes cluster.
## Risk assessment

![Imgur](https://i.imgur.com/WyAFLyb.png)
## Docker and docker-compose
The first step to deploy the application, was to containerise the application. This means that as long as docker and docker-compose are installed in a machine, the app will be able to run.
To do so, the dockerfiles for the frontend and the backend of the app were created as well as a Docker Compose file to take care of all the services needed. 
Initially, a container was utilised for the database for testing purposes as shown in the following image.

![database-docker](https://i.imgur.com/GrRxU1n.png)

## Jenkins pipeline
Jenkins is a powerful tool used in CI/CD pipelines. In other words, it allows the developer to set a number of tasks needed to deploy an application. In this specific case, the stages of the pipeline are: declarative checkout SCM, build images, tag & push image, test and deploy.

![Imgur](https://i.imgur.com/rM1Pony.png)

The Jenkins job was linked to the development branch of the github repository through a webhook to automate the process even more. 
The plugins installed in Jenkins (other than the ones that are there by default) where: ssh agent and docker pipeline.
A lot of attention was paid to ensure that no sensitive data was exposed to the public, through the use of secret texts and secret files. This ensured that the data would not be visible from the console output interface of the Jenkins pipeline.
## Ansible 
Ansible was the tool used to install jenkins and configure the jenkins user on the virtual machine. For security reasons, the private key needed to ssh into the virtual machine, was stored locally and not in the github repository.
## Terraform
Terraform was used to create the 2 vms needed for Jenkins and for testing and the 2 databases. Again, measures were taken to avoid exposing data that should be hidden. For instance, the database variable file was not uploaded to github. Another step taken was to create an IAM user in Amazon Web Services with programmatic access and full access to both EC2 and RDS services. Then the aws cli was configured from the local command line. This ensured that no authentication password or secret key was needed in the terraform files. 
Once the creation process is complete, the output was configured to be the public ip addresses of the instances, as well as the databases endpoints.
![Imgur](https://i.imgur.com/QGFJCcD.png)
The ip addresses of the ec2 instances were then manually pasted into the ansible inventory.
## Kubernetes
Kubernetes is a tool that simplifies the deployment of applications and their scalability.
In this project a kubernetes cluster was created in Google Cloud Platform as it included in the free trial. The platform was initialised manually by creating a cluster beforehand and logging into it. This was necessary to allow the jenkins pipeline to deploy the application as smoothly as possible. For security reasons a secret text service is created through jenkins on the kubernetes cluster everytime the app is run.
To ensure that the only necessary port was accessible, nginx was used to reverse proxy the path. To run the nginx service, a sidecar model was utilised as described in QA Academy course content ([Sidecar model](https://portal.qa-community.co.uk/~/cne/learning/kubernetes/kubernetes--sidecar-model)). 

## Summary of environment configuration
1. Log in to an aws cli account
2. Run the terraform script and wait for the output
4. Configure the databases through the Create.sql file
3. Copy the IP addresses of the EC2 instances into the Ansible inventory
4. Run the ansible playbook (installs git, docker and docker compose in all the vm and jenkins in one vm)
5. Log into Jenkins and store the required environment variables and ssh keys
6. Install the required plugins on Jenkins
7. Set up the webhook in github and configure the pipeline on Jenkins
8. Log into docker in the test vm
9. Configure the kubernetes cluster and add jenkins public ssh key to the authorised hosts of the vm
10. The application is ready to run

## Final Product
The final product is a CI/CD pipeline fully functioning.
1. When a change is made in the development branch of the github repository, the Jenkins pipeline begins
2. A new image is built and uploaded to the docker hub repository with a specific version tag
3. Jenkins ssh into the test VM where it pulls the required docker images then it starts the application
4. The application is tested and the coverage report for the backend and the frontend are pushed into the github repository

5. The changes are uploaded to the master branch of the github repository
6. Jenkins logs into the kubernetes cluster where it pulls the required docker images and updates the text of the frontend and backend kubernetes yaml files to refer to the correct docker images
7. The application is deployed to the kubernetes cluster
8. If needed, the application can roll back to a previous version

## Future work
Although the app deployment is functional, it is still far away from being fully automated. In particular, the setting up of the environment requires the developer to go through nine steps.
Next, although the app is fully tested whenever a change is made, the application is deployed regardless. This problem was not faced due to time constraints, however in a real world scenario, it is essential to ensure that only a fully working product is deployed.

## Summary
The various stages of the development of the CI/CD pipeline of QA Cloud Native Practical Project were outlined, as well as the risks, the planning of the project and the potential future work.

#### Author: Judith Edhogbo

