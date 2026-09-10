# key pair login

resource aws_key_pair my_key{
    key_name ="tera-ec2"
    public_key= file("tera-ec2.pub")
}

# vpc and security group

resource aws_default_vpc default {

}

resource  aws_security_group my_security_grouo {
  name = "automate-sg"
  description = "this isa tg"
  vpc_id = aws_default_vpc.default.id   #interpolation

  # inbound rule

  ingress{
    from_port=22
    to_port =22
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
    description="open ssh"
  }

   ingress{
    from_port=80
    to_port =80
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
    description="open http"
  }

  
  # outbond Rule

  egress{
    from_port=0
    to_port =0
    protocol="-1"
    cidr_blocks=["0.0.0.0/0"]
    description="all acess"
  }

   tags = {
    Name = "automate-sg"
  }

}

# ec2 instance

resource "aws_instance" "my_instance" {
 key_name=aws_key_pair.my_key.key_name
 security_groups=[aws_security_group.my_security_grouo.name]
 instance_type = var.ec2_instance_type
 ami=var.ec2_ami_id        #ubentu
  user_data=file("install_nginx.sh")
  root_block_device {
    
    volume_size = var.ec2_root_storage_size
    volume_type = "gp3"
  }

  tags = {
    Name = "HelloWorld"
  }
}