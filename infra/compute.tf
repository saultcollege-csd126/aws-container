resource "aws_instance" "xpix_server" {
  ami                         = var.ami_id
  instance_type               = "t3.micro"
  availability_zone           = "us-east-1a"
  associate_public_ip_address = true
  iam_instance_profile        = var.instance_profile_name
  key_name                    = "login1"
  subnet_id                   = aws_subnet.public_1.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "xpix-app-server"
  }
}

import {
  to = aws_instance.xpix_server
  id = "i-0be9ad15dfef6e0c6"
}