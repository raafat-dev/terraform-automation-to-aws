provider "aws" {

  access_key = "access_key"
  secret_key = "secret_key"
  region     = "us-east-1"
}

resource "aws_eip" "staticip" {
vpc = true

}


resource "aws_s3_bucket" "buckupserver" {

  bucket= "raafat-bucker-05"
}

output "printstaticip" {

value = aws_eip.staticip

}

output "prints3bucketdetails" {

value = aws_s3_bucket.buckupserver

}
