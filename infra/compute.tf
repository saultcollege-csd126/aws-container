resource "aws_instance" "xpix" {
  ami                         = var.ami_id
  instance_type               = "t3.micro"
  availability_zone           = "us-east-1a"
  subnet_id                   = aws_subnet.public_a.id
  vpc_security_group_ids      = [aws_security_group.xpix.id]
  iam_instance_profile        = var.instance_profile_name
  associate_public_ip_address = true
  key_name                    = "KIET"
  user_data                   = file("${path.module}/user_data.sh")

  tags = {
    Name = "xpix-app-server"
  }
}

import {
  to = aws_instance.xpix
  id = "i-002d0765463ee9988"
}

import {
  to = aws_cognito_user_pool.xpix
  id = "us-east-1_kCeVdXi7E"
}

import {
  to = aws_cognito_user_pool_client.xpix
  id = "us-east-1_kCeVdXi7E/46oudbk4nu6lkk81jkb80usdab"
}