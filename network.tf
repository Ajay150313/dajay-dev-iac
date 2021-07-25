# create an IGW (Internet Gateway)
# It enables your vpc to connect to the internet
resource "aws_internet_gateway" "dev-igw" {
    vpc_id = "${aws_vpc.dev-vpc.id}"

    tags = {
        Name = "dev-igw"
    }
}

# create a custom route table for public subnets
# public subnets can reach to the internet buy using this
resource "aws_route_table" "dev-public-rt" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0" //associated subnet can reach everywhere
        gateway_id = "${aws_internet_gateway.dev-igw.id}" //CRT uses this IGW to reach internet
    }    
    tags = {
        Name = "dev-public-rt"
    }
}

# # route table for private subnet
# resource "aws_route_table" "dev-private-rt" {
#     vpc_id = "${aws_vpc.dev-vpc.id}"
#     route {
#         cidr_block = "10.0.0.32/27" //associated subnet can reach everywhere
#         }

#     tags = {
#         Name = "dev-private-rt"
#     }
# }


# route table association for the public subnets
resource "aws_route_table_association" "prod-crta-public-subnet-1" {
    subnet_id = "${aws_subnet.dev-public-subnet-1.id}"
    route_table_id = "${aws_route_table.dev-public-rt.id}"
}

resource "aws_route_table_association" "prod-crta-public-subnet-2" {
    subnet_id = "${aws_subnet.dev-public-subnet-2.id}"
    route_table_id = "${aws_route_table.dev-public-rt.id}"
}

# resource "aws_route_table_association" "prod-crta-private-subnet-1" {
#     subnet_id = "${aws_subnet.dev-private-subnet-1.id}"
#     route_table_id = "${aws_route_table.dev-private-rt.id}"
# }

# resource "aws_route_table_association" "prod-crta-private-subnet-2" {
#     subnet_id = "${aws_subnet.dev-private-subnet-2.id}"
#     route_table_id = "${aws_route_table.dev-private-rt.id}"
# }

# security group
resource "aws_security_group" "ssh-allowed" {

    vpc_id = "${aws_vpc.dev-vpc.id}"

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        
        // This means, all ip address are allowed to ssh !
        // Do not do it in the production. Put your office or home address in it!
        cidr_blocks = ["0.0.0.0/0"]
    }

    //If you do not add this rule, you can not reach the NGIX
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }


    tags = {
        Name = "ssh-allowed"
    }
}
