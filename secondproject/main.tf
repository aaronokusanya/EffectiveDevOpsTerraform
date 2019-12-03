provider "aws" {
	region = "us-east-1"
}

resource "aws_vpc" "massivevpc" {
	cidr_block = "${var.vpc_cidr}"
	instance_tenancy = "default"

	tags = {
	name = "massive"
	}
}

resource "aws_subnet" "massiveingress_subnet_az_1" {
	vpc_id = "${aws_vpc.massivevpc.id}"
	cidr_block = "${var.ingress_subnet_az_1_CIDR}"
	availability_zone = "us-east-1a"
	map_public_ip_on_launch = "true"

	tags = {
	name = "Ingress Subnet 1"
	}

	depends_on = [
	"aws_vpc.massivevpc"
	]
}

resource "aws_subnet" "massiveingress_subnet_az_2" {
	vpc_id = "${aws_vpc.massivevpc.id}"
	cidr_block = "${var.ingress_subnet_az_2_CIDR}"
	availability_zone = "us-east-1b"
	map_public_ip_on_launch = "true"

	tags = {
	name = "ingress subnet 2"
	}

	depends_on = [
	"aws_vpc.massivevpc"
	]
}

resource "aws_subnet" "massiveprivate_subnet_az_1" {
	vpc_id = "${aws_vpc.massivevpc.id}"
	cidr_block = "${var.private_subnet_az_1_CIDR}"
	availability_zone = "us-east-1a"

	tags = {
	name = "private subnet 1"
	}

	depends_on = [
	"aws_vpc.massivevpc"
	]
}

resource "aws_subnet" "massiveprivate_subnet_az_2" {
	vpc_id = "${aws_vpc.massivevpc.id}"
	cidr_block = "${var.private_subnet_az_2_CIDR}"
	availability_zone = "us-east-1b"

	tags = {
	name = "private subnet 2"
	}

	depends_on = [
	"aws_vpc.massivevpc"
	]
}

resource "aws_security_group" "massivesg" {
	name = "Massive Security Group"
	vpc_id = "${aws_vpc.massivevpc.id}"

	ingress {
	from_port = 8080
	to_port = 8080
	protocol = "tcp"
	cidr_blocks = ["${var.ingress_subnet_az_1_CIDR}"]
}

	tags = {
	name = "massive security group"
	}

	depends_on = [
	"aws_vpc.massivevpc"

	]
}

resource "aws_instance" "massivewebserver" {
	ami = "ami-40d28157"
	instance_type = "t2.micro"
	vpc_security_group_ids = ["${aws_security_group.massivesg.id}"]

	user_data = <<-EOF
				#1/bin/bash
				echo "Hello World" > index.html
				nohup busybox httpd -f -p 8080 &
				EOF

	tags = {
	name = "massive web server"
	}			
}