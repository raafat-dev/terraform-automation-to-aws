
provider "aws" {

  access_key = "access-key"
  secret_key = "secret-key"
  region     = "us-east-1"
}

locals {
   tags = {
    Owner = "System Team"
    service = "adminsitration"
  }
}
resource "aws_instance" "app" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro"
   tags = local.tags
}

resource "aws_instance" "db" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.small"
   tags = local.tags
}

resource "aws_ebs_volume" "db-volumes" {
  availability_zone = "us-west-2a"
  size              = 20
  tags = local.tags
}
