
provider "aws" {

  access_key = "access-key"
  secret_key = "secret-key"
  region     = "us-east-1"
}


data "aws_ami" "app_ami" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "first-EC2" {
    ami = data.aws_ami.app_ami.id
   instance_type = "t2.micro"
}
