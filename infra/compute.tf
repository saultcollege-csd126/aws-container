resource "aws_instance" "xpix" {
  ami                         = var.ami_id
  associate_public_ip_address = true
  availability_zone           = "us-east-1a"
  iam_instance_profile        = var.instance_profile_name
  instance_type               = "t3.micro"
  key_name                    = "xpix-key"
  subnet_id                   = aws_subnet.public_a.id
  vpc_security_group_ids      = [aws_security_group.xpix.id]
  user_data                   = file("${path.module}/user_data.sh")

  tags = {
    Name = "xpix-app-server"
  }
}

