provider "aws" {
  region = "ca-central-1" 
}

resource "aws_instance" "example" {
  ami           = "ami-0bb0ed6088d3b1bec"
  instance_type = "t2.micro"
  key_name      = "mikew-1pass"

user_data = file("${path.module}/cloud-init.yml")

  tags = {
    Name = "dev-template"
  }

  vpc_security_group_ids = [aws_security_group.ssh-in-global.id]
}

resource "aws_security_group" "ssh-in-global" {
  name_prefix = "ssh-"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

