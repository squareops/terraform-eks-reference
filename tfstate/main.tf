locals {
  name        = "tfstate"
  region      = "us-east-2"
  environment = "prod"
  bucket_name = "stage"
}

module "backend" {
  source             = "squareops/tfstate/aws"
  version            = "1.0.0"
  logging            = false
  environment        = local.environment
  bucket_name        = local.bucket_name        #unique global s3 bucket name
  force_destroy      = true
  versioning_enabled = true
}
