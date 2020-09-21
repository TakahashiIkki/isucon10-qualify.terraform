provider "aws" {
  profile = var.profile
  region = var.region
}

data "aws_vpc" "main" {
  id = var.vpc_id
}

#
# security groups
#
resource "aws_security_group" "isucon_sg" {
  name   = "isucon-sg"
  vpc_id = data.aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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

resource "aws_instance" "isucon-server" {
  ami = "ami-02b658ac34935766f"
  instance_type = "t3a.small"
  # isucon10 のインフラは 1CPU / 2Memory なので調整
  cpu_core_count = 1
  cpu_threads_per_core = 1
  key_name = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.isucon_sg.id]
}
