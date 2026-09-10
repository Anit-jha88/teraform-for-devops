# ==========================================
# KEY PAIR
# ==========================================

resource "aws_key_pair" "my_key" {
  key_name   = "tera-ec2"
  public_key = file("tera-ec2.pub")
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
  name        = "automate-sg"
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
    Name = "automate-sg"
  }
}


# ==========================================
# EC2 INSTANCES
# ==========================================

resource "aws_instance" "my_instance" {

  for_each = tomap({
    anit-server-1 = "t3.micro"
    anit-server-2 = "t2.medium"
  })

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
  instance_type = each.value
  ami           = var.ec2_ami_id

  # User Data Script
  user_data = file("install_nginx.sh")


  # Root Volume
  root_block_device {
    volume_size = var.env=="prd" ? 20 : var.ec2_defoult_root_storage_size
    volume_type = "gp3"
  }


  # Tags
  tags = {
    Name = each.key
  }
}