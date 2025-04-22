terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-3331"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}