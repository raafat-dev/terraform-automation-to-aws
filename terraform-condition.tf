provider "aws" {

  access_key = "access-key"
  secret_key = "secret-key"
  region     = "us-east-1"
}


variable "is-Dev" {
default=true

}

resource "aws_instance" "test" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro"
   count = var.is-Dev == true ? 3 : 0
}

resource "aws_instance" "prod" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.large"
   count = var.is-Dev == false ? 2 : 0
}
