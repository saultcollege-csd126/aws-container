variable "aws_region" {
    type = string
    default = "us-east-1"

}

variable ami_id {
    type = string
    default = "ami-098e39bafa7e7303d"
}
variable instance_profile_name {
    type = string
    default = "LabRole"
} 
