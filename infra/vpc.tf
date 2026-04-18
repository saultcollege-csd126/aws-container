resource "aws_vpc" "xpix" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "pic-show-vpc"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.xpix.id
  cidr_block        = "10.0.128.0/20"
  availability_zone = "us-east-1a"

  tags = {
     Name = "pic-show-subnet-private1-us-east-1a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.xpix.id
  cidr_block        = "10.0.144.0/20"
  availability_zone = "us-east-1b"

  tags = {
    Name = "pic-show-subnet-private2-us-east-1b"
  }
}
resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.xpix.id
  cidr_block        = "10.0.0.0/20"
  availability_zone = "us-east-1a"

  tags = {
    Name = "pic-show-subnet-public1-us-east-1a"
  }
}
resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.xpix.id
  cidr_block        = "10.0.16.0/20"
  availability_zone = "us-east-1b"

  tags = {
    Name = "pic-show-subnet-public2-us-east-1b"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.xpix.id

  tags = {
    Name = "pic-show-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.xpix.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "pic-show-rtb-public"
  }
}

resource "aws_route_table" "private_a" {
  vpc_id = aws_vpc.xpix.id

  tags = {
    Name = "pic-show-rtb-private1-us-east-1a"
  }
}

resource "aws_route_table" "private_b" {
  vpc_id = aws_vpc.xpix.id

  tags = {
    Name = "pic-show-rtb-private2-us-east-1b"
  }
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_a.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_b.id
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "xpix" {
  name        = "xpix-app-server"
  description = "allow XPix app server connections"
  vpc_id      = aws_vpc.xpix.id
}

resource "aws_vpc_security_group_ingress_rule" "http" {
    security_group_id = aws_security_group.xpix.id
    cidr_ipv4 =  "0.0.0.0/0"
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"

}

import {
  to = aws_vpc.xpix
  id = "vpc-05e6720a8225368c8"
}

import {
  to = aws_subnet.private_a
  id = "subnet-0e73466a4a1b982c7"
}

import {
  to = aws_subnet.private_b
  id = "subnet-021b1972db9590e67"
}

import {
  to = aws_subnet.public_a
  id = "subnet-0258b599cd24abf4c"
}
import {
  to = aws_subnet.public_b
  id = "subnet-0e4b2099411891270"
}

import {
  to = aws_internet_gateway.gw
  id = "igw-0f53390fda86a1e28"
}

import {
  to = aws_route_table.public
  id = "rtb-07354104795b1d282"
}

import {
  to = aws_route_table.private_a
  id = "rtb-0031966a02a646b91"
}

import {
  to = aws_route_table.private_b
  id = "rtb-0b8a9332d04b8f229"
}

import {
    to = aws_route_table_association.private_a
    id = "subnet-0e73466a4a1b982c7/rtb-0031966a02a646b91"
}
import {
  to = aws_route_table_association.private_b
  id = "subnet-021b1972db9590e67/rtb-0b8a9332d04b8f229"  
}
import {
  to = aws_route_table_association.public_a
  id = "subnet-0258b599cd24abf4c/rtb-07354104795b1d282"  
}     
import {
  to = aws_route_table_association.public_b
  id = "subnet-0e4b2099411891270/rtb-07354104795b1d282"  
}
import {
  to = aws_security_group.xpix
  id = "sg-028ff5568b4a8b8a6"
}

import {
  to = aws_vpc_security_group_ingress_rule.http
  id = "sgr-00cf79aa97fe94a39"
}


