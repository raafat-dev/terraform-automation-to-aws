provider "aws" {
  access_key = "access-key"
  secret_key = "secret-key"
  region     = "us-east-1"
}


resource "aws_instance" "myInstance" {
  ami           = "ami-098f16afa9edf40be"
  instance_type = "t2.micro"
  user_data     = <<-EOF
                  #!/bin/bash
                  sudo su
                  yum -y install httpd
                  echo "<p> My Instance! </p>" >> /var/www/html/index.html
                  sudo systemctl enable httpd
                  sudo systemctl start httpd
                  EOF
}

output "DNS" {
  value = aws_instance.myInstance.public_dns
}
