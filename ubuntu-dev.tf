provider "aws" {
  region = "ca-central-1" 
}

resource "aws_instance" "example" {
  ami           = "ami-0bb0ed6088d3b1bec"
  instance_type = "t2.micro"
  key_name      = "mikew-1pass"

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get upgrade -y
              apt-get install -y build-essential curl nginx npm

              useradd -m -s /bin/bash mikew
              echo 'mikew ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
              mkdir -p /home/mikew/.ssh
              curl -o /home/mikew/.ssh/authorized_keys https://github.com/vicmike.keys
              chown -R mikew:mikew /home/mikew/.ssh
              chmod 700 /home/mikew/.ssh
              chmod 600 /home/mikew/.ssh/authorized_keys

              npm install -g nvm
              npm install -g yarn
              npm install -g typescript
              npm install -g pm2

              nvm install 12.15.0
              nvm install 14.20.0
              nvm use 14.20.0

              mkdir -p /opt/docker
              mkdir -p /opt/www
              EOF

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

