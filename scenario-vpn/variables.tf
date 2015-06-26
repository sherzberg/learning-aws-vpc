
variable "region" {
    default = "us-east-1"
}

variable "amis" {
  description = "Base AMI to launch the instances with"
  default = {
    us-east-1 = "ami-d85e75b0"
  }
}

variable "instance_type" {
  description = "Instance type to launch with"
  default = {
    us-east-1 = "t1.micro"
  }
}
variable "vpc_cidr" {
  description = "VPC CIDR block range"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR block range"
  default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
  description = "Private Subnet CIDR block range"
  default = "10.0.5.0/24"
}

