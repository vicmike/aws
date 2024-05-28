provider "aws" {
  region = "ca-central-1" 
  profile = var.aws_profile
}

resource "aws_instance" "dev-server" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = templatefile("${path.module}/cloud-init.yml", {
    user_name = var.user_name
    github_user = var.github_user
    hostname = var.hostname
  })
  tags = {
    Name = var.instance_name
    Project = var.project_id
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

data "aws_instance" "dev-server" {
  instance_id = aws_instance.dev-server.id
}

resource "aws_route53_record" "backend" {
  zone_id = "Z103080424ATLJF97H0IQ"
  name    = "backend.gsdev.cc"
  type    = "A"
  ttl     = "30"
  allow_overwrite = true
  records = [data.aws_instance.dev-server.public_ip]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "dashboard" {
  zone_id = "Z103080424ATLJF97H0IQ"
  name    = "dashboard.gsdev.cc"
  type    = "A"
  ttl     = "30"
  allow_overwrite = true
  records = [data.aws_instance.dev-server.public_ip]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "assessment" {
  zone_id = "Z103080424ATLJF97H0IQ"
  name    = "assessment.gsdev.cc"
  type    = "A"
  ttl     = "30"
  allow_overwrite = true
  records = [data.aws_instance.dev-server.public_ip]

  lifecycle {
    create_before_destroy = true
  }
}

output "public_ip" {
  description = "The public IP of the EC2 instance"
  value       = data.aws_instance.dev-server.public_ip
}
