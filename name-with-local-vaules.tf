
locals {
  instance_ids= concat(aws_instance.app.*.id , aws_instance.db.*.id)
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
