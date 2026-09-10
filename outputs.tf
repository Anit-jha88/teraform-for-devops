# nornal output 
 # output "ec2_public_ip" {
 # value=aws_instance.my_instance.public_ip
 # }

 # output "ec2_public_dns" {
 # value=aws_instance.my_instance.public_dns
 # }

 # output "ec2_privatec_ip" {
 #  value=aws_instance.my_instance.private_ip
 #  }

# output for Count

# output "ec2_public_ip" {
#   value=aws_instance.my_instance[*].public_ip
#  }

#  output "ec2_public_dns" {
#  value=aws_instance.my_instance[*].public_dns
#  }

#  output "ec2_privatec_ip" {
#  value=aws_instance.my_instance[*].private_ip
#  }

# output for foreach
output "ec2_public_ip" {
  value=[ 
    for key in aws_instance.my_instance: key.public_ip
  ]
  }

  output "ec2_public_dns" {
  value=[ 
    for key in aws_instance.my_instance: key.public_dns
  ]
  }

   output "ec2_privatec_ip" {
  value=[ 
    for key in aws_instance.my_instance: key.private_ip
  ]
  }