# ==========================================
# KEY PAIR
# ==========================================

resource "aws_key_pair" "my_key" {
  key_name   = "${var.env}-tera-ec2"
  public_key = file("tera-ec2.pub")

  tags = {
    Environment = var.env
  }
}


# ==========================================
# DEFAULT VPC
# ==========================================

resource "aws_default_vpc" "default" {
}


# ==========================================
# SECURITY GROUP
# ==========================================

resource "aws_security_group" "my_security_group" {
  name        = "${var.env}-infra-app-sg"
  description = "Security group for automated EC2 instances"
  vpc_id      = aws_default_vpc.default.id

  # --------------------------
  # INBOUND RULES
  # --------------------------

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Open SSH"
  }

  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Open HTTP"
  }


  # --------------------------
  # OUTBOUND RULE
  # --------------------------

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }


  tags = {
    Name = "${var.env}-infra-app-sg"
  }
}


# ==========================================
# EC2 INSTANCES
# ==========================================

resource "aws_instance" "my_instance" {

  count = var.instant_count

  depends_on = [
    aws_security_group.my_security_group,
    aws_key_pair.my_key
  ]

  # Key Pair
  key_name = aws_key_pair.my_key.key_name

  # Security Group
  security_groups = [
    aws_security_group.my_security_group.name
  ]

  # Instance Configuration
  instance_type = var.instant_type
  ami           = var.ec2_ami_id

  # User Data Script
  user_data = file("install_nginx.sh")


  # Root Volume
  root_block_device {
    volume_size = var.env=="prd" ? 20 : 10
    volume_type = "gp3"
  }


  # Tags
  tags = {
    Name = "${var.env}-infra-app-instance"
    Enviroment = var.env
  }
}