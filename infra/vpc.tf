resource "aws_vpc" "assignment3-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "assignment3-vpc"
    }
}

import {
  to = aws_vpc.assignment3-vpc
  id = "vpc-087f27c10202d5de8"
}

resource "aws_subnet" "public-1" {
    vpc_id = aws_vpc.assignment3-vpc.id
    cidr_block = "10.0.1.0/24"

    tags = {
        Name = "assignment3-subnet-public1-us-east-1a"
    }
}

import {
  to = aws_subnet.public-1
  id = "subnet-060eda1ad1dea1963"
}

resource "aws_subnet" "public-2" {
    vpc_id = aws_vpc.assignment3-vpc.id
    cidr_block = "10.0.2.0/24"

    tags = {
        Name = "assignment3-subnet-public2-us-east-1b"
    }
}


import {
    to = aws_subnet.public-2
    id = "subnet-08f8bb0bc896f4f44"
}

resource "aws_subnet" "private-1" {
    vpc_id = aws_vpc.assignment3-vpc.id
    cidr_block = "10.0.3.0/24"

    tags = {
        Name = "assignment3-subnet-private1-us-east-1a"
    }
}

import {
    to = aws_subnet.private-1
    id = "subnet-0049d8ecaea475589"
}

resource "aws_subnet" "private-2" {
    vpc_id = aws_vpc.assignment3-vpc.id
    cidr_block = "10.0.4.0/24"

    tags = {
        Name = "assignment3-subnet-private2-us-east-1b"
    }
}

import {
    to = aws_subnet.private-2
    id = "subnet-01b200937775b445e"
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.assignment3-vpc.id

    tags = {
        Name = "assignment3-igw"
    }
}

import {
  to = aws_internet_gateway.igw
  id = "igw-082657d37c54a06b2"
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.assignment3-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    
    tags = {
        Name = "assignment3-rtb-public"
    }
}

import {
    to = aws_route_table.public
    id = "rtb-0d61ad72d961972d5"
}

resource "aws_route_table" "private-1" {
    vpc_id = aws_vpc.assignment3-vpc.id

    tags = {
        Name = "assignment3-rtb-private1-us-east-1a"
    }
}

import {
    to = aws_route_table.private-1
    id = "rtb-072dba0a3bbe31d1e"    
}

resource "aws_route_table" "private-2" {
    vpc_id = aws_vpc.assignment3-vpc.id

    tags = {
        Name = "assignment3-rtb-private2-us-east-1b"
    }
}

import {
    to = aws_route_table.private-2
    id = "rtb-05b38a2085cfd80a1"
}

resource "aws_route_table_association" "public-1" {
    subnet_id = aws_subnet.public-1.id
    route_table_id = aws_route_table.public.id
}

import {
  to = aws_route_table_association.public-1
    id = "subnet-060eda1ad1dea1963/rtb-0d61ad72d961972d5"
}

resource "aws_route_table_association" "public-2" {
    subnet_id = aws_subnet.public-2.id
    route_table_id = aws_route_table.public.id
}

import {
  to = aws_route_table_association.public-2
    id = "subnet-08f8bb0bc896f4f44/rtb-0d61ad72d961972d5"
}

resource "aws_route_table_association" "private-1" {
    subnet_id = aws_subnet.private-1.id
    route_table_id = aws_route_table.private-1.id
}

import {
    to = aws_route_table_association.private-1
    id = "subnet-0049d8ecaea475589/rtb-072dba0a3bbe31d1e"
}

resource "aws_route_table_association" "private-2" {
    subnet_id = aws_subnet.private-2.id
    route_table_id = aws_route_table.private-2.id
}

import {
    to = aws_route_table_association.private-2
    id = "subnet-01b200937775b445e/rtb-05b38a2085cfd80a1"
}

resource "aws_security_group" "xpix-app-server" {
    vpc_id = aws_vpc.assignment3-vpc.id
    description = "allow XPix app server connections"
}

import {
  to = aws_security_group.xpix-app-server
  id = "sg-0798e1139cd351660"
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rule" {
    security_group_id = aws_security_group.xpix-app-server.id

    cidr_ipv4   = "0.0.0.0/0"
    from_port   = 22
    ip_protocol = "tcp"
    to_port     = 22
}

import {
    to = aws_vpc_security_group_ingress_rule.ingress_rule
    id = "sgr-0b5c849c86672ac62"
}

