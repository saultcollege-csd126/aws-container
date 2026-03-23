resource "aws_vpc" "myvpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "CSD126-VPC"
}
}

import {
  to = aws_vpc.myvpc
  id = "vpc-06c83daddea3b943c" 
}


resource "aws_subnet" "Assignment-3-subnet-public1-us-east-1a" {
  vpc_id = aws_vpc.myvpc.id
  availability_zone = "us-east-1a"
  cidr_block = "192.168.0.0/20"
  tags = {
    Name = "Assignment-3-subnet-public1-us-east-1a"
  }
}

import {
  to = aws_subnet.Assignment-3-subnet-public1-us-east-1a
  id = "subnet-06466dfde90a2d45d"
}

resource "aws_subnet" "Assignment-3-subnet-private1-us-east-1a" {
  vpc_id = aws_vpc.myvpc.id
  availability_zone = "us-east-1a"
  cidr_block =        "192.168.128.0/20" 
  tags = {
    Name = "Assignment-3-subnet-private1-us-east-1a"
  }
}

import {
  to = aws_subnet.Assignment-3-subnet-private1-us-east-1a 
  id = "subnet-0b815f25ae60cf2e8"
}

resource "aws_subnet" "Assignment-3-subnet-public2-us-east-1b" {
  vpc_id = aws_vpc.myvpc.id
  availability_zone = "us-east-1b"
  cidr_block =        "192.168.16.0/20"
  tags = {
    Name = "Assignment-3-subnet-public2-us-east-1b"
  }
}

import {
  to = aws_subnet.Assignment-3-subnet-public2-us-east-1b
  id = "subnet-0cf6507f80d257d56"
}

resource "aws_subnet" "Assignment-3-subnet-private2-us-east-1b" {
  vpc_id = aws_vpc.myvpc.id
  availability_zone = "us-east-1b"
  cidr_block =        "192.168.144.0/20"
  tags = {
    Name = "Assignment-3-subnet-private2-us-east-1b"
  }
}

import {
  to = aws_subnet.Assignment-3-subnet-private2-us-east-1b
  id = "subnet-0aa9b38b5c17a1d9f"
}

resource "aws_internet_gateway" "Assignment-3-igw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
  Name = "Assignment-3-igw"
}
}

import {
  to = aws_internet_gateway.Assignment-3-igw
  id = "igw-07873fdbfdd1299a5"
}

resource "aws_route_table" "Assignment-3-rtb-public" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Assignment-3-igw.id
  }
  tags = {
  Name = "Assignment-3-rtb-public"
}
}

import {
  to = aws_route_table.Assignment-3-rtb-public
  id = "rtb-058851a4b5bc252d5"
}

resource "aws_route_table" "Assignment-3-rtb-private1-us-east-1a" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "Assignment-3-rtb-private1-us-east-1a"
  }
}

import {
  to = aws_route_table.Assignment-3-rtb-private1-us-east-1a
  id = "rtb-0d09a43a2d92b375a"
}

resource "aws_route_table" "Assignment-3-rtb-private2-us-east-1b" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "Assignment-3-rtb-private2-us-east-1b"
  }
}


import {
  to = aws_route_table.Assignment-3-rtb-private2-us-east-1b
  id = "rtb-03139e64af9efd5ff"
}
resource "aws_route_table_association" "rta_public1a" {
  subnet_id      = aws_subnet.Assignment-3-subnet-public1-us-east-1a.id
  route_table_id = aws_route_table.Assignment-3-rtb-public.id
}

import {
  to = aws_route_table_association.rta_public1a
  id = "subnet-06466dfde90a2d45d/rtb-058851a4b5bc252d5"
}

resource "aws_route_table_association" "rta_public1b" {
  subnet_id      = aws_subnet.Assignment-3-subnet-public2-us-east-1b.id
  route_table_id = aws_route_table.Assignment-3-rtb-public.id
}

import {
  to = aws_route_table_association.rta_public1b
  id = "subnet-0cf6507f80d257d56/rtb-058851a4b5bc252d5"
}

resource "aws_route_table_association" "rta_private1a" {
  subnet_id      = aws_subnet.Assignment-3-subnet-private1-us-east-1a.id
  route_table_id = aws_route_table.Assignment-3-rtb-private1-us-east-1a.id 
}

import {
  to = aws_route_table_association.rta_private1a
  id = "subnet-0b815f25ae60cf2e8/rtb-0d09a43a2d92b375a"
}

resource "aws_route_table_association" "rta_private1b" {
  subnet_id      = aws_subnet.Assignment-3-subnet-private2-us-east-1b.id 
  route_table_id = aws_route_table.Assignment-3-rtb-private2-us-east-1b.id
}

import {
  to = aws_route_table_association.rta_private1b
  id = "subnet-0aa9b38b5c17a1d9f/rtb-03139e64af9efd5ff"
}

resource "aws_security_group" "xpix-app-server" {
  description = "allow XPix app server connections"
  vpc_id      = aws_vpc.myvpc.id

}

import {
  to = aws_security_group.xpix-app-server
  id = "sg-07037c6fa3af30e7a"
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.xpix-app-server.id 
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

import {
  to = aws_vpc_security_group_ingress_rule.allow_tls_ipv4
  id = "sgr-02f88f1e2940d98c8"
}