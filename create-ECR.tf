
variable "access-key" {
  default = "access-key"
}

variable "secret-key" {
  default = "secret-key"
}

variable "region" {
  default = "us-east-1"
}


provider "aws" {

  access_key = var.access-key
  secret_key = var.secret-key
  region     = var.region
}


resource "aws_ecr_repository" "dev_app" {
  name = "dev_app"
}

output "aws_ecr_repository_dev_app_url" {
	value = "${aws_ecr_repository.dev_app.repository_url}"
}
