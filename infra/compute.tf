resource "aws_instance" "xpix-app-server" {
  ami                         = var.ami_id
  associate_public_ip_address = true
  availability_zone           = "us-east-1a"
  iam_instance_profile        = var.instance_profile_name
  instance_type               = "t3.micro"
  key_name                    = "CSD126-Keypair"
  subnet_id                   = aws_subnet.Assignment-3-subnet-public1-us-east-1a.id
  vpc_security_group_ids      = [aws_security_group.xpix-app-server.id]
  user_data_base64 = base64encode(file("${path.module}/user_data.sh"))
  tags = {
    Name = "xpix-app-server"
  }
  lifecycle {
    ignore_changes = [
      user_data
    ]
  }
}

import {
  to = aws_instance.xpix-app-server
  id = "i-01795168290156ce3" 
}