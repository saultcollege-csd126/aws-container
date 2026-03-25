variable "aws_region" {
  description = "AWS region for the lab"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID used by the XPix EC2 instance"
  type        = string
  default     = "ami-02dfbd4ff395f2a1b"
}

variable "instance_profile_name" {
  description = "IAM instance profile attached to the EC2 instance"
  type        = string
  default     = "LabInstanceProfile"
}