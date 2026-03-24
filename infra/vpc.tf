resource "aws_vpc" "xpix" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Assignment 3-vpc"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.xpix.id
  cidr_block              = "192.168.0.0/20"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Assignment 3-subnet-public1-us-east-1a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.xpix.id
  cidr_block              = "192.168.16.0/20"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "Assignment 3-subnet-public2-us-east-1b"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id                  = aws_vpc.xpix.id
  cidr_block              = "192.168.128.0/20"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Assignment 3-subnet-private1-us-east-1a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id                  = aws_vpc.xpix.id
  cidr_block              = "192.168.144.0/20"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "Assignment 3-subnet-private2-us-east-1b"
  }
}

resource "aws_internet_gateway" "xpix" {
  vpc_id = aws_vpc.xpix.id

  tags = {
    Name = "Assignment 3-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.xpix.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.xpix.id
  }

  tags = {
    Name = "Assignment 3-rtb-public"
  }
}

resource "aws_route_table" "private_a" {
  vpc_id = aws_vpc.xpix.id

  tags = {
    Name = "Assignment 3-rtb-private1-us-east-1a"
  }
}

resource "aws_route_table" "private_b" {
  vpc_id = aws_vpc.xpix.id

  tags = {
    Name = "Assignment 3-rtb-private2-us-east-1b"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_a.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_b.id
}

resource "aws_security_group" "xpix" {
  name        = "xpix-app-server"
  description = "allow XPix app server connections"
  vpc_id      = aws_vpc.xpix.id


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


import {
  to = aws_vpc.xpix
  id = "vpc-0c8a253b79bb96653"
}

import {
  to = aws_subnet.public_a
  id = "subnet-0e2bf8282ff02df6b"
}

import {
  to = aws_subnet.public_b
  id = "subnet-00e7b7173e85ba347"
}

import {
  to = aws_subnet.private_a
  id = "subnet-0e93ef3a77d808a05"
}

import {
  to = aws_subnet.private_b
  id = "subnet-097930848e54f3bf3"
}

import {
  to = aws_internet_gateway.xpix
  id = "igw-071c05bc57b1cb347"
}

import {
  to = aws_route_table.public
  id = "rtb-02476bb55db348251"
}

import {
  to = aws_route_table.private_a
  id = "rtb-07ab356d727725cdf"
}

import {
  to = aws_route_table.private_b
  id = "rtb-0719dbc04117542c3"
}

import {
  to = aws_route_table_association.public_a
  id = "subnet-0e2bf8282ff02df6b/rtb-02476bb55db348251"
}

import {
  to = aws_route_table_association.public_b
  id = "subnet-00e7b7173e85ba347/rtb-02476bb55db348251"
}

import {
  to = aws_route_table_association.private_a
  id = "subnet-0e93ef3a77d808a05/rtb-07ab356d727725cdf"
}

import {
  to = aws_route_table_association.private_b
  id = "subnet-097930848e54f3bf3/rtb-0719dbc04117542c3"
}

import {
  to = aws_security_group.xpix
  id = "sg-0bb1d1a019218822b"
}
