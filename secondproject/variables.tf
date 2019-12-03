variable "aws_region" {
	description = "the aws region to create resources in"
	default = "us-east-1"
}

variable "vpc_cidr" {
	description = "VPC CIDR"
	default = "10.0.0.0/16"
}

variable "ingress_subnet_az_1_CIDR" {
	description = "Ingress Subnet AZ 1 CIDR"
	default = "10.0.1.0/24"
}

variable "ingress_subnet_az_2_CIDR" {
	description = "Ingress Subnet AZ 2 CIDR"
	default = "10.0.2.0/24"
}

variable "private_subnet_az_1_CIDR" {
	description = "Private Subnet AZ 1 CIDR"
	default = "10.0.3.0/24"
}

variable "private_subnet_az_2_CIDR"{
	description = "Private Subnet AZ 2 CIDR"
	default = "10.0.4.0/24"
}