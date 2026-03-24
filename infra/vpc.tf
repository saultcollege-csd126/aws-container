/*
/ VPC
*/
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "XPix-VPC-vpc"
  }
}

import {
  to = aws_vpc.main
  id = "vpc-05918976890d155b9"
}

/*
/ Subnets 
*/
resource "aws_subnet" "public_1" {
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.1.0/24"

  tags = {
    Name = "XPix-VPC-subnet-public1-us-east-1a"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.2.0/24"

  tags = {
    Name = "XPix-VPC-subnet-public2-us-east-1b"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.3.0/24"

  tags = {
    Name = "XPix-VPC-subnet-private1-us-east-1a"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.4.0/24"

  tags = {
    Name = "XPix-VPC-subnet-private2-us-east-1b"
  }
}

import {
  to = aws_subnet.public_1
  id = "subnet-0d3e4913be50d0e43"
}

import {
  to = aws_subnet.public_2
  id = "subnet-06661351221064bcb"
}

import {
  to = aws_subnet.private_1
  id = "subnet-092cabafc6a39b693"
}

import {
  to = aws_subnet.private_2
  id = "subnet-06ae0963878851274"
}   

/*
/ Gateways
*/
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "XPix-VPC-igw"
  }
}

import {
  to = aws_internet_gateway.igw
  id = "igw-0e6d4778790ba3fc7"
}

/*
/ Route Tables
*/
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "XPix-VPC-rtb-public"
  }
}

resource "aws_route_table" "private_1" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "XPix-VPC-rtb-private1-us-east-1a"
  }
}

resource "aws_route_table" "private_2" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "XPix-VPC-rtb-private2-us-east-1b"
  }
}

import {
  to = aws_route_table.public
  id = "rtb-0175c411011a8a342"
}

import {
  to = aws_route_table.private_1
  id = "rtb-0644247c56988ef56"
}

import {
  to = aws_route_table.private_2
  id = "rtb-061cb37459a5efdd1"
}

/*
/ Route Table Associations
*/
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_1.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_2.id
}

import {
  to = aws_route_table_association.public_1
  id = "subnet-0d3e4913be50d0e43/rtb-0175c411011a8a342"
}

import {
  to = aws_route_table_association.public_2
  id = "subnet-06661351221064bcb/rtb-0175c411011a8a342"
}

import {
  to = aws_route_table_association.private_1
  id = "subnet-092cabafc6a39b693/rtb-0644247c56988ef56"
}

import {
  to = aws_route_table_association.private_2
  id = "subnet-06ae0963878851274/rtb-061cb37459a5efdd1"
}

/*
/ Security Groups
*/  
resource "aws_security_group" "app_server" {
  description = "allow XPix app server connections"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "xpix-app-server"
  }
}

import {
  to = aws_security_group.app_server
  id = "sg-0feb8b5ebef9d9aa9"
}

/*
/ Security Group ingress rules
*/
resource "aws_vpc_security_group_ingress_rule" "rule" {
  security_group_id = aws_security_group.app_server.id

  from_port         = 22
  to_port           = 22
  ip_protocol          = "tcp"
  cidr_ipv4              = "0.0.0.0/0"
}

import {
  to = aws_vpc_security_group_ingress_rule.rule
  id = "sgr-0ad2c8ebe2137f671"
}