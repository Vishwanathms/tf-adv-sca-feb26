provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "secure_app1" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"

  tags = {
    Name = "Secure-App-Server"
  }
}

# ❌ BAD: Missing encryption, missing tags
resource "aws_s3_bucket" "bad_bucket01" {
  bucket = "lab11-bad-bucket-demo-12345"
}

# ❌ BAD: Open to the world
resource "aws_security_group" "bad_sg" {
  name        = "lab11-open-sg"
  description = "Open SG for lab"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # <-- should fail
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
