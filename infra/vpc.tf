resource "aws_vpc" "main" {
  cidr_block = "172.31.0.0/16"
}

import {
  to = aws_vpc.main
  id = "vpc-059a7729efde8976f"
}

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.31.0.0/20"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

import {
  to = aws_subnet.public_1
  id = "subnet-0d911fc27dd037643"
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.31.16.0/20"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true
}

import {
  to = aws_subnet.public_2
  id = "subnet-0290f9be110ab2773"
}

resource "aws_subnet" "private_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.31.32.0/20"
  availability_zone       = "us-east-1d"
  map_public_ip_on_launch = true
}

import {
  to = aws_subnet.private_1
  id = "subnet-075008ce3f751b7eb"
}

resource "aws_subnet" "private_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.31.48.0/20"
  availability_zone       = "us-east-1e"
  map_public_ip_on_launch = true
}

import {
  to = aws_subnet.private_2
  id = "subnet-0f6ea8d7acbf60dc2"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

import {
  to = aws_internet_gateway.igw
  id = "igw-03687ff43efd29cf5"
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
}

import {
  to = aws_route_table.main
  id = "rtb-022d0caf027ddc6c0"
}

# ✅ FIXED: Route is now imported instead of created
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

import {
  to = aws_route.internet_access
  id = "rtb-022d0caf027ddc6c0_0.0.0.0/0"
}

resource "aws_security_group" "web_sg" {
  name        = "xpix-app-serve"
  description = "allow XPix app server connections"
  vpc_id      = aws_vpc.main.id
}

import {
  to = aws_security_group.web_sg
  id = "sg-0905252c27e2b5f1d"
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.web_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

import {
  to = aws_vpc_security_group_ingress_rule.ssh
  id = "sgr-046c6b86847bd31f9"
}