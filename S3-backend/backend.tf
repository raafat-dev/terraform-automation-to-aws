
terraform {
  backend "s3" {
    bucket = "raafat-demo"
    key    = "remotedemo.tfstate"
    region = "us-east-1"
    access_key = "acess-key"
    secret_key = "secret-key"
  }
}
