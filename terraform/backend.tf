terraform {
  backend "s3" {
    bucket = "terraform-primary"
    key    = "us-east-1-state"
    region = "us-east-1"
  }
}