resource "aws_instance" "xpix-app-server" {
    ami = var.ami_id
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public-1.id
    iam_instance_profile = var.instance_profile_name
    associate_public_ip_address = true
    availability_zone = "us-east-1a"
    key_name = "Key pair login"
    
    vpc_security_group_ids = [aws_security_group.xpix-app-server.id]

    user_data = file("${path.module}/user_data.sh")

    tags = {
        Name = "xpix-app-server"
    }
}

import {
    to = aws_instance.xpix-app-server
    id = "i-097d52dc30e775c20"
}

output "ec2_public_ip" {
  description = "Public IP of the XPix EC2 instance"
  value       = aws_instance.xpix-app-server.public_ip
}