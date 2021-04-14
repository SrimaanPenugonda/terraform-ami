resource "aws_instance" "ami_instance" {
  ami           = data.aws_ami.ami.id
  instance_type = "t3.small"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  tags           = {
      Name       = "${var.COMPONENT}-ami"
  }
}

//security grp
resource "aws_security_group" "allow_ssh" {
  name        = "allow-${var.COMPONENT}-ami-sg"
  description = "Allow SSH inbound traffic to AMI"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // allow internet
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-${var.COMPONENT}-ami-sg"
  }
}
resource "null_resource" "provisioner" {
  provisioner "remote-exec" { // connect and execute commands in remote instance
    connection {
      host        = aws_instance.ami_instance.public_ip
      user        = "root"
      password    = "DevOps321" //don't hardcode like this
    }
    inline        =[
      "yum install make -y",
      "git clone https://github.com/SrimaanPenugonda/roboshop.git",
      "cd roboshop",
      "make ${var.COMPONENT}"
    ]
  }
}