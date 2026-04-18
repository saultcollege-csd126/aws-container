variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "ami_id" {
  type = string
  default = "ami-0c3389a4fa5bddaad"
}

variable "instance_profile_name"  {
  type    = string
  default = "LabInstanceProfile"
}