resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = "t2.micro"

  subnet_id = aws_subnet.public_1.id

  vpc_security_group_ids = [
    aws_security_group.app_server.id
  ]

  tags = {
    Name = "xpix-app-server"
  }

  lifecycle {
    ignore_changes = [
      user_data,
      user_data_replace_on_change
    ]
  }
}

import {
  to = aws_instance.app
  id = "i-0446a6662cbd14529"
}