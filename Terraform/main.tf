provider "aws" {
  version                 = "~> 2.0"
  region                  = "eu-west-1"
  shared_credentials_file = "~/.aws/credentials"
}

module "aws_vpc" {
  source = "./VPC"
}

module "testing_sg" {
  source        = "./SecurityGroups"
  name          = "testSG"
  vpc_id        = module.aws_vpc.vpc_id
  ingress_ports = [22, 80]
}

module "jenkins_sg" {
  source        = "./SecurityGroups"
  name          = "jenkinsSG"
  vpc_id        = module.aws_vpc.vpc_id
  ingress_ports = [22, 8080]
}

module "Testing" {
  source                 = "./EC2"
  subnet_id              = module.aws_vpc.public_subnetA_id
  vpc_security_group_ids = module.testing_sg.aws_wsg_id
  tags = {
    Name = "Testing"
  }
  associate_public_ip_address = true
  ami                         = "ami-08a2aed6e0a6f9c7d"
}

module "Jenkins" {
  source                 = "./EC2"
  subnet_id              = module.aws_vpc.public_subnetA_id
  vpc_security_group_ids = module.jenkins_sg.aws_wsg_id
  tags = {
    Name = "Jenkins"
  }
  associate_public_ip_address = true
}

module "test" {
  source     = "./DB"
  name       = "test"
  identifier = "test"

}

module "deployment" {
  source     = "./DB"
  name       = "deployment"
  identifier = "deployment"

}













