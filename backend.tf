terraform {
  backend "s3" {
    region = "us-east-2"
    bucket = "eks-ref-bucket"
    key    = "eks/terraform.tfstate"
  }
}
