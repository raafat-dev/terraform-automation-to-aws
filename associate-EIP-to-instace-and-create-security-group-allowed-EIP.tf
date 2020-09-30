provider "aws" {

  access_key = "access_key"
  secret_key = "secret_key"
  region     = "us-east-1"
}


resource "aws_instance" "ubuntu-instance" {
  ami           = "ami-0f40c8f97004632f9"
  instance_type = "t2.micro"
  tags = {
    Name = "ubuntu server"
  }
}

resource "aws_eip" "staticip" {
    vpc = true
}

resource "aws_eip_association" "eip-assoc" {
    instance_id = aws_instance.ubuntu-instance.id
    allocation_id=aws_eip.staticip.id
}


resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "allow-ssh"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.staticip.public_ip}/32"]
  }
  }
