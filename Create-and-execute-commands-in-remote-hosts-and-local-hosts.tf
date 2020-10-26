provider "aws" {

  access_key = "access-key"
  secret_key = "sevret-key"
  region     = "us-east-1"
}


resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH into VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http into VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Outbound Allowed"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "myec2" {
   ami = "ami-0f40c8f97004632f9"
   instance_type = "t2.micro"
   key_name = "codedeploy-keypair-instance"
   vpc_security_group_ids  = [aws_security_group.allow_ssh.id]


   provisioner "local-exec" {
   command = "echo ${aws_instance.myec2.private_ip} >> private_ips.txt"
 }

   provisioner "remote-exec" {
     inline = [
       "sudo apt -y install nano",
       "sudo apt -y install apache2",
       "sudo service apache2 start"
     ]
   }
   provisioner "remote-exec" {
       when    = destroy
       inline = [
         "sudo apt -y remove nano",
         "sudo apt -y remove apache2"

       ]
     }
   connection {
     type = "ssh"
     user = "ubuntu"
     private_key = file("${path.module}/codedeploy-keypair-instance.pem")
     host = self.public_ip
   }
}
