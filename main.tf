terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.48.0"
    }
  }
}

provider "aws" {
  region  = "${var.region}"
}

resource "tls_private_key" "pk" {                         # Generate Private Key
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "${var.key-name}"                           # Create KeyPair in AWS
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" {                               # Create aws_key.pem on PC
    command = "echo '${tls_private_key.pk.private_key_pem}' > aws_key.pem && chmod 600 aws_key.pem"
  }
}

resource "aws_security_group" "allow_tcp_22_and_8080" {    # Create Security Group
  name         = "${var.security-group}"
  description  = "Allow ssh and http inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  
  ingress {
    from_port   = 8080
    to_port     = 8080
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

resource "aws_instance" "build_srv" {
  count = 1
  depends_on = [aws_key_pair.kp, aws_security_group.allow_tcp_22_and_8080]
  ami = "ami-05f7491af5eef733a"
  instance_type = "t3a.micro"
  key_name = "${var.key-name}"
  security_groups = [
    "${var.security-group}"
  ]
  tags = {
    Name = "Build"
  }
}

