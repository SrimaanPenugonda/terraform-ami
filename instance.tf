resource "aws_instance" "ami_instance" {
  ami           = data.aws_ami.ami.id
  instance_type = "t3.small"
  tags           = {
      Name       = "${var.COMPONENT}-ami"
  }
}

resource "null_resource" "provisioner" {
  provisioner "remote-exec" {
    connection {
      host        = aws_instance.ami_instance.public_ip
      user        = "root"
      password    = "DevOps321" //dont hardcode like this
    }
    inline        =[
      "yum install make -y"
      "git clone https://github.com/SrimaanPenugonda/roboshop.git"
      "cd roboshop"
      "make ${var.COMPONENT}"
    ]
  }
}