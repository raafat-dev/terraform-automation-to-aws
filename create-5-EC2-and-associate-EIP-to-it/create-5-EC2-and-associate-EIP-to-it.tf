provider "aws" {
  access_key = "access_key"
  secret_key = "secret_key"
  region     = "us-east-1"
}

resource "aws_instance" "myinstances" {
  ami = "ami-0f40c8f97004632f9"
  instance_type = "t2.micro"
  count = 5
  tags = {
    name = var.instances-names[count.index]

  }
}

resource "aws_eip" "myStaticsIp" {
    vpc = true
    count = 5
    tags = {
      name = var.my-EIP-name[count.index]
    }
}


resource "aws_eip_association" "eip-assoc" {
    instance_id = aws_instance.myinstances[count.index].id
    allocation_id = aws_eip.myStaticsIp[count.index].id
    count = 5
}
