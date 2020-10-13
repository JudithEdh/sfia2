# QAC SFIA2 Project
## Introduction
The purpose of the project was to deploy a given application through a continuous integration pipeline using all the concepts and skills aquired in the second part of the training in QA academy ([Cloud Native - Practical Project Specification](https://portal.qa-community.co.uk/~/cne/projects/practical--cn)). 
## Table of Contents
- [Requirements](#requirements)
- [Recipes Collection](#recipes-collection)
- [MOSCOW approach](#moscow-approach)
- [Database](#database)
- [CI Pipeline](#ci-pipeline)
- [Planning](#planning)
- [Risk assessment](#risk-assessment)
- [Project components](#project-components)
- [Future work and reflection on the project](#future-work-and-reflection-on-the-project)
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
4. The app must be deployen on Kubernetes
5. NGINX must be used to reverse proxy
- #### Should Have
1. Ability to roll back to a previous version of the application
- ### Wont have
1. Ability to set up all the tools needed (including a pipeline) with a few simple commands
