resource "aws_vpc" "dajay-dev-vpc" {
    cidr_block = "10.0.0.0/26"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    instance_tenancy = "default"

    tags = {
        Name = "dajay-dev-vpc"
    }
}

resource "aws_subnet" "dajay-dev-public-subnet-1" {
    vpc_id = "${aws_vpc.dajay-dev-vpc.id}"
    cidr_block = "10.0.0.0/28"
    map_public_ip_on_launch = "true" 
    availability_zone = "us-east-2a"

    tags = {
        Name = "dajay-dev-public-subnet-1"
    }
}

resource "aws_subnet" "dajay-dev-public-subnet-2" {
    vpc_id = "${aws_vpc.dajay-dev-vpc.id}"
    cidr_block = "10.0.0.16/28"
    map_public_ip_on_launch = "true" 
    availability_zone = "us-east-2b"

    tags = {
        Name = "dajay-dev-public-subnet-2"
    }
}

resource "aws_subnet" "dajay-dev-private-subnet-1" {
    vpc_id = "${aws_vpc.dajay-dev-vpc.id}"
    cidr_block = "10.0.0.32/28"
    availability_zone = "us-east-2a"

    tags = {
        Name = "dajay-dev-private-subnet-1"
    }
}

resource "aws_subnet" "dajay-dev-private-subnet-2" {
    vpc_id = "${aws_vpc.dajay-dev-vpc.id}"
    cidr_block = "10.0.0.48/28"
    availability_zone = "us-east-2b"

    tags = {
        Name = "dajay-dev-private-subnet-2"
    }
}
