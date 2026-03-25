resource "aws_vpc" "asmt" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "CSD126-VPC-JACOB-PELLETIER"
  }
}

import {
  to = aws_vpc.asmt
  id = "vpc-020910e01785ef220"
}


resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.asmt.id
  cidr_block              = "192.168.0.0/20"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "lab3-subnet-public1-us-east-1a"
  }
}

import {
  to = aws_subnet.public1
  id = "subnet-0d13f9acb13d38334"
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.asmt.id
  cidr_block              = "192.168.16.0/20"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "lab3-subnet-public2-us-east-1b"
  }
}

import {
  to = aws_subnet.public2
  id = "subnet-06eb2936a0dbbab42"
}


resource "aws_subnet" "private1" {
  vpc_id                  = aws_vpc.asmt.id
  cidr_block              = "192.168.128.0/20"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "lab3-subnet-private1-us-east-1a"
  }
}

import {
  to = aws_subnet.private1
  id = "subnet-0aa34126d342b1de3"
}

resource "aws_subnet" "private2" {
  vpc_id                  = aws_vpc.asmt.id
  cidr_block              = "192.168.144.0/20"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "lab3-subnet-private2-us-east-1b"
  }
}

import {
  to = aws_subnet.private2
  id = "subnet-053ed6d4689f6b897"
}

resource "aws_internet_gateway" "asmt" {
  vpc_id = aws_vpc.asmt.id

  tags = {
    Name = "lab3-igw"
  }
}

import {
  to = aws_internet_gateway.asmt
  id = "igw-0d2a9216a4c911812"
}

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

resource "aws_route_table" "private1" {
  vpc_id = aws_vpc.asmt.id

  tags = {
    Name = "lab3-rtb-private1-us-east-1a"
  }
}

import {
  to = aws_route_table.private1
  id = "rtb-079d5c433cb293513"
}

resource "aws_route_table" "private2" {
  vpc_id = aws_vpc.asmt.id

  tags = {
    Name = "lab3-rtb-private2-us-east-1b"
  }
}

import {
  to = aws_route_table.private2
  id = "rtb-05cea142de4911b19"
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

import {
  to = aws_route_table_association.public1
  id = "subnet-0d13f9acb13d38334/rtb-077c06ec37c81d160"
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

import {
  to = aws_route_table_association.public2
  id = "subnet-06eb2936a0dbbab42/rtb-077c06ec37c81d160"
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private1.id
}

import {
  to = aws_route_table_association.private1
  id = "subnet-0aa34126d342b1de3/rtb-079d5c433cb293513"
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private2.id
}

import {
  to = aws_route_table_association.private2
  id = "subnet-053ed6d4689f6b897/rtb-05cea142de4911b19"
}

resource "aws_security_group" "asmt" {
  name        = "xpix_web_server"
  description = "Allows SSH!!!"
  vpc_id      = aws_vpc.asmt.id
}

import {
  to = aws_security_group.asmt
  id = "sg-0551e4fbb9d3eaf80"
}

resource "aws_vpc_security_group_ingress_rule" "asmt" {
  security_group_id = aws_security_group.asmt.id
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
}

import {
  to = aws_vpc_security_group_ingress_rule.asmt
  id = "sgr-0328795256f3b9563"
}