# create an IGW (Internet Gateway)
# It enables your vpc to connect to the internet
resource "aws_internet_gateway" "dajay-dev-igw" {
    vpc_id = "${aws_vpc.dajay-dev-vpc.id}"

    tags = {
        Name = "dajay-dev-igw"
    }
}

# create a custom route table for public subnets
resource "aws_route_table" "dajay-dev-public-rt" {
    vpc_id = "${aws_vpc.dajay-dev-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0" //associated subnet can reach everywhere
        gateway_id = "${aws_internet_gateway.dajay-dev-igw.id}" //CRT uses this IGW to reach internet
    }    
    tags = {
        Name = "dajay-dev-public-rt"
    }
}


# route table association for the public subnets
resource "aws_route_table_association" "dajay-dev-crta-public-subnet-1" {
    subnet_id = "${aws_subnet.dajay-dev-public-subnet-1.id}"
    route_table_id = "${aws_route_table.dajay-dev-public-rt.id}"
}

resource "aws_route_table_association" "dajay-dev-crta-public-subnet-2" {
    subnet_id = "${aws_subnet.dajay-dev-public-subnet-2.id}"
    route_table_id = "${aws_route_table.dajay-dev-public-rt.id}"
}
