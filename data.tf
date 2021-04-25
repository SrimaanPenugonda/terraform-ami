data "aws_ami" "ami" {
  most_recent   = true
  owners        = ["973714476881"]
#  filter {
#    name   = "image-id"
#    values = ["ami-079a3f3cf00741286"]
#  }  ami id will change all time so filtering on name
  filter {
    name   = "name"
    values = ["Centos-7-DevOps-Practice"]
  }
}

#get the credentials from AWS secret manager
data "aws_secretsmanager_secret" "creds" {
  name     = "roboshop-${var.ENV}"
}

data "aws_secretsmanager_secret_version" "creds"{
 secret_id = data.aws_secretsmanager_secret.creds.id
}