resource "aws_vpc" "asmt" {
    cidr_block = "192.168.0.0/16"
    tags= {
        Name = "lab3-vpc"}

}

import {
to = aws_vpc.asmt 
id = "vpc-020910e01785ef220"
}

//--------------------------SUBNETS-------------------------------

//PUBLIC subnets-----
resource "aws_subnet" "public1" {
    vpc_id = aws_vpc.asmt.id
    cidr_block = "192.168.0.0/20"

    tags = {
        Name = "lab3-subnet-public1-us-east-1a"
    }

    tags_all = {
      Name = "lab3-subnet-public1-us-east-1a"
    }

}

import {
    to = aws_subnet.public1
    id = "subnet-0d13f9acb13d38334"
}

resource "aws_subnet" "public2" {
    vpc_id = aws_vpc.asmt.id
    cidr_block = "192.168.16.0/20"

    tags = {
        Name = "lab3-subnet-public2-us-east-1b"
    }

    tags_all = {
        Name = "lab3-subnet-public2-us-east-1b"
    }
}

import{
to = aws_subnet.public2
id = "subnet-06eb2936a0dbbab42"
}

//PRIVATE subnets------
resource "aws_subnet" "private1" {
    vpc_id = aws_vpc.asmt.id
    cidr_block = "192.168.128.0/20"

    tags = {
    Name = "lab3-subnet-private1-us-east-1a"
}

    tags_all = {
    Name = "lab3-subnet-private1-us-east-1a"
}

}

import {
    to = aws_subnet.private1
    id = "subnet-0aa34126d342b1de3"
}

resource "aws_subnet" "private2" {
    vpc_id = aws_vpc.asmt.id
    cidr_block = "192.168.144.0/20"


    tags = {
        Name = "lab3-subnet-private2-us-east-1b"
    }

    tags_all = {
      Name = "lab3-subnet-private2-us-east-1b"
    }

}

import {
    to = aws_subnet.private2
    id = "subnet-053ed6d4689f6b897"
}

//--------------------------internet gateway-------------------------------//

resource "aws_internet_gateway" "asmt" {
    vpc_id = aws_vpc.asmt.id

    tags     = {
          Name = "lab3-igw"
        }
     tags_all = {
          Name = "lab3-igw"
        }
   
}

import {
     to = aws_internet_gateway.asmt
     id = "igw-0d2a9216a4c911812"
}
///


resource "aws_route_table" "public" {
        vpc_id = aws_vpc.asmt.id

        route {
            cidr_block = "0.0.0.0/0"
            gateway_id = aws_internet_gateway.asmt.id 
        }



         tags = {
          Name = "lab3-rtb-public" 
         }

}
import {
    to = aws_route_table.public
    id = "rtb-077c06ec37c81d160"

}
///
resource "aws_route_table" "private2"{
        vpc_id = aws_vpc.asmt.id

        tags = {

            Name = "lab3-rtb-private2-us-east-1b"

        }

        tags_all = {

            Name =  "lab3-rtb-private2-us-east-1b"

        }
}

import {
    to = aws_route_table.private2
    id = "rtb-05cea142de4911b19"

}
///
resource "aws_route_table" "private1"{
    
    vpc_id = aws_vpc.asmt.id


     tags = {

            Name = "lab3-rtb-private1-us-east-1a"

        }

        tags_all = {

            Name =  "lab3-rtb-private1-us-east-1a"
        }
}

import {
    to = aws_route_table.private1
    id = "rtb-079d5c433cb293513"

}

///TABLES/////
//public
resource "aws_route_table_association" "public1"{
    subnet_id = aws_subnet.public1.id
    route_table_id = aws_route_table.public.id
}

import {
    to = aws_route_table_association.public1
    id = "subnet-0d13f9acb13d38334/rtb-077c06ec37c81d160" 
    }

//public2
resource "aws_route_table_association" "public2" {
    subnet_id = aws_subnet.public2.id
    route_table_id = aws_route_table.public.id
}

import {
    to = aws_route_table_association.public2
    id = "subnet-06eb2936a0dbbab42/rtb-077c06ec37c81d160"
}

//private1
resource "aws_route_table_association" "private1" {
    subnet_id = aws_subnet.private1.id
    route_table_id = aws_route_table.private1.id
}

import {
    to = aws_route_table_association.private1
    id = "subnet-0aa34126d342b1de3/rtb-079d5c433cb293513"
}

resource "aws_route_table_association" "private2" {
    subnet_id = aws_subnet.private2.id
    route_table_id = aws_route_table.private2.id
}

import {
    to = aws_route_table_association.private2
    id = "subnet-053ed6d4689f6b897/rtb-05cea142de4911b19"
}

//SECURITY GROUP

resource "aws_security_group" "asmt" {
    name = "xpix_web_server" 
    vpc_id = aws_vpc.asmt.id
    description = "Allows SSH!!!"


    tags = {

    }

    tags_all = {
      
    }
}

import {

to = aws_security_group.asmt
id = "sg-0966c159ff8f533d9"
}


resource "aws_vpc_security_group_ingress_rule" "asmt" {
    security_group_id = aws_security_group.asmt.id
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 22
    to_port = 22

}


import {

    to = aws_vpc_security_group_ingress_rule.asmt
    id = "sgr-0328795256f3b9563"
}


    