variable "ami" {
  description = "AMI of EC2 instance, default is Ubuntu 18.04"
  default     = "ami-04137ed1a354f54c4"
}

variable "instance-type" {
  description = "The type of machine to run the image on"
  default     = "t2.micro"
}

variable "pem-key" {
  description = "The Key which I will be able to SSH in to my EC2 using"
  default     = "terraform_key"
}

variable "subnet_id" {
  description = "The ID of the subnet which I will deploy EC2 in to"
  default     = "4"
}

variable "vpc_security_group_ids" {
  description = "The IDs of the security group we will attach to the EC2"
  default     = "2"
}

variable "tags" {
  type        = map(string)
  description = "Map of tags"
  default     = { Name : "MyEC2", Project : "Sfia2 Project" }
}

variable "associate_public_ip_address" {
  description = "Associate Public IP to machines that need public access"
  default     = false
}


