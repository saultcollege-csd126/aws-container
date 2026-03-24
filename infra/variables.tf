variable "aws_region" {
  default = "us-east-1"
}

variable "ami_id" {
  description = "AMI used by EC2"
  default     = "ami-02dfbd4ff395f2a1b"
}

variable "instance_profile_name" {
  default = "LabInstanceProfile"
}