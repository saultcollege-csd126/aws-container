resource "aws_instance" "asmt" {  
    ami = var.ami_id
    associate_public_ip_address = true
    availability_zone = "us-east-1a"
    iam_instance_profile = var.instance_profile_name
    instance_type = "t3.micro"
    key_name = "xpixkeypair"
    subnet_id = aws_subnet.public1.id
    vpc_security_group_ids = [aws_security_group.asmt.id]
    user_data = file("/workspaces/aws-container_CSD126/resources/user_data.sh")
    tags = {
        Name = "xpix_serv"
    }
}

import {
    to = aws_instance.asmt
    id = "i-09b9a9cd88e262a39"
}

output "ec2_private_ip"{
    description = "Here is the private IP of the EC2 Instance -> "
    value = aws_instance.asmt.private_ip
}
