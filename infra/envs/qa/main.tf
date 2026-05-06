terraform {
  required_version = ">= 1.7.0"

  backend "s3" {
    bucket         = "tf-state-image-processor-303771000432"
    key = "env/qa/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-locks-image-processor"
    encrypt        = true
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "infra-deployer"
}