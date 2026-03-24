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

variable "user_pool_name" {
  default = "us-east-1_afks661PG"
}

variable "client_name" {
  default = "5pj95crr3bdbb1nfs82587idf6"
}