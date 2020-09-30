provider "aws" {
  access_key = "access-key"
  secret_key = "secret-key"
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0f40c8f97004632f9"
  instance_type = "t2.micro"
}
