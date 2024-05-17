provider "aws" {
  region = "ca-central-1" 
}

resource "aws_instance" "dev-server" {
  ami           = "ami-0bb0ed6088d3b1bec"
  instance_type = "t2.micro"
  key_name      = "mikew-1pass"

  user_data = templatefile("${path.module}/cloud-init.yml", {
    user_name = var.user_name
  })
  tags = {
    Name = var.instance_name
    Project = "Development server"
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

