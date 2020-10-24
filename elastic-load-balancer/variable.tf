variable "access_key" {
  default = "access_key"
}

variable "secret_key" {
  default = "secret_key"
}



variable "key_name" {
  description = "Name of the SSH keypair to use in AWS."
  default= "codedeploy-keypair-instance"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-east-1"
}

variable "aws_amis" {
  default = {
    "us-east-1" = "ami-0323c3dd2da7fb37d"
    "us-west-2" = "ami-7f675e4f"
  }
}
