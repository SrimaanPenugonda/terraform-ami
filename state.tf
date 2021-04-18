terraform {
  backend "s3" {
#    bucket           = "srimaan-terraform-state-files" //existing bucket name to store state files
#    key              = "ami/terraform.tfstate" //path in bucket
#    region           = "us-east-1"
#    dynamodb_table   = "terraform" //dynamodb table name
    #Mention this at make file init to create diff path for every component in bucket(using COMPONENT)
  }
}


provider "aws" {
  region = "us-east-1"
}