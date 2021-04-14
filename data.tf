data "aws_ami" "ami" {
  most_recent   = true
  owners        = ["973714476881"]
  filter {
    name   = "image-id"
    values = ["ami-079a3f3cf00741286"]
  }
}
