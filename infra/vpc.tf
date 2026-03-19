resource "aws_vpc" "asmt" {
    cidr_block = "10.0.0.0/16"
  
}

resource "aws_subnet" "az1_public" {
    vpc_id = aws_vpc.asmt.id
    availability_zone = "us-east-1a"
    cidr_block = "10.0.0.0/24"
  
}

resource "aws_subnet" "public_2" {
    vpc_id = aws_vpc.asmt.id
    availability_zone = "us-east-1b"
    cidr_block = "10.0.0.0/24"
  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.asmt.id
  
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.asmt.id
    route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
  
}

