variable "aws_region" {
    type = string
    default = "us-east-1"

}

variable ami_id {
    type = string
    default = "ami-02dfbd4ff395f2a1b"
}
variable instance_profile_name {
    type = string
    default = "LabInstanceProfile"
}