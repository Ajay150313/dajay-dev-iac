resource "aws_vpc" "dev-vpc" {
    cidr_block = "10.0.0.0/26"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    instance_tenancy = "default"

    tags = {
        Name = "dev-vpc"
    }
}

resource "aws_subnet" "dev-public-subnet-1" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    cidr_block = "10.0.0.0/28"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "us-east-2a"

    tags = {
        Name = "dev-public-subnet-1"
    }
}

resource "aws_subnet" "dev-public-subnet-2" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    cidr_block = "10.0.0.16/28"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "us-east-2b"

    tags = {
        Name = "dev-public-subnet-2"
    }
}

resource "aws_subnet" "dev-private-subnet-1" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    cidr_block = "10.0.0.32/28"
    # map_public_ip_on_launch = "false" //it makes this a private subnet
    availability_zone = "us-east-2a"

    tags = {
        Name = "dev-private-subnet-1"
    }
}

resource "aws_subnet" "dev-private-subnet-2" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    cidr_block = "10.0.0.48/28"
    # map_public_ip_on_launch = "false" //it makes this a private subnet
    availability_zone = "us-east-2b"

    tags = {
        Name = "dev-private-subnet-2"
    }
}
