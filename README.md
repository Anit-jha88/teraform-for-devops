
# Terraform AWS Infrastructure Automation 

This project demonstrates how to provision and manage AWS infrastructure using **Terraform Infrastructure as Code (IaC)**.

The goal of this project is to automate AWS resource creation instead of creating resources manually from the AWS Console.

## 🚀 Technologies Used 

* Terraform
* AWS
* EC2
* VPC
* Security Groups
* Key Pair
* Linux
* Git & GitHub

## 📌 Project Architecture

Terraform is used to provision the following AWS resources:

```text
Developer
    |
    v
Terraform
    |
    +-------------------+
    |                   |
    v                   v
   AWS                 GitHub
    |
    +---- VPC
    |
    +---- Security Group
    |
    +---- EC2 Instance
    |
    +---- Key Pair
```

## 📂 Project Structure

```text
terraform-aws-infrastructure/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── .gitignore
└── README.md
```

## ⚙️ Prerequisites

Before running this project, install:

1. Terraform
2. AWS CLI
3. Git
4. An AWS Account

Verify Terraform installation:

```bash
terraform --version
```

Verify AWS CLI:

```bash
aws --version
```

## 🔐 AWS Configuration

Configure your AWS credentials using:

```bash
aws configure
```

Enter:

```text
AWS Access Key ID
AWS Secret Access Key
AWS Region
Output Format
```

Example region:

```text
ap-south-1
```

> **Security:** Never upload AWS Access Keys, Secret Keys, `.pem` files, or Terraform state files containing sensitive information to GitHub.

## 🔑 SSH Key Pair

The project can use an existing public key to create an AWS EC2 Key Pair.

Example:

```hcl
resource "aws_key_pair" "my_key" {
  key_name   = "tera-ec2"
  public_key = file("tera-ec2.pub")
}
```

Terraform reads the public key from:

```text
tera-ec2.pub
```

The private key should **never** be committed to GitHub.

## 🏗️ Terraform Workflow

Terraform generally follows this workflow:

```text
Write Configuration
       |
       v
terraform init
       |
       v
terraform validate
       |
       v
terraform plan
       |
       v
terraform apply
       |
       v
AWS Infrastructure
```

### 1. Initialize Terraform

```bash
terraform init
```

This downloads the required Terraform providers and initializes the working directory.

### 2. Format Code

```bash
terraform fmt
```

### 3. Validate Configuration

```bash
terraform validate
```

This checks whether the Terraform configuration is syntactically valid.

### 4. Create Execution Plan

```bash
terraform plan
```

This shows what Terraform is going to create, modify, or destroy.

### 5. Create Infrastructure

```bash
terraform apply
```

Confirm with:

```text
yes
```

Terraform will then provision the AWS resources.

## 📤 Terraform Outputs

After successful deployment:

```bash
terraform output
```

You can use outputs to display information such as:

```text
EC2 Public IP
EC2 Instance ID
Security Group ID
VPC ID
```

## 🗑️ Destroy Infrastructure

To remove the resources created by Terraform:

```bash
terraform destroy
```

Confirm:

```text
yes
```

**Important:** `terraform destroy` permanently deletes the resources managed by the configuration.

## 📄 Important Terraform Files

### main.tf

Contains the main AWS infrastructure resources.

Example:

```hcl
resource "aws_instance" "my_server" {
  ami           = "ami-xxxxxxxx"
  instance_type = "t2.micro"

  key_name = aws_key_pair.my_key.key_name

  security_groups = [
    aws_security_group.my_security_group.name
  ]

  tags = {
    Name = "Terraform-EC2"
  }
}
```

### variables.tf

Used to define reusable input variables.

```hcl
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
```

### outputs.tf

Used to display useful information after deployment.

```hcl
output "instance_public_ip" {
  value = aws_instance.my_server.public_ip
}
```

## 🔒 .gitignore

The following files should not be committed to GitHub:

```gitignore
.terraform/
*.tfstate
*.tfstate.*
terraform.tfvars
*.pem
*.key
.terraform.lock.hcl
```

> Depending on your team/project policy, you may choose to commit `.terraform.lock.hcl` because it locks provider versions and is commonly recommended for reproducible builds.

## 🧠 What I Learned

Through this project, I learned:

* Infrastructure as Code using Terraform
* Terraform providers
* AWS EC2 provisioning
* AWS VPC concepts
* Security Groups
* AWS Key Pair configuration
* Terraform variables
* Terraform outputs
* Terraform state
* `terraform init`
* `terraform plan`
* `terraform apply`
* `terraform destroy`
* Git and GitHub integration

## 🔄 Future Improvements

The project can be extended with:

* Custom VPC
* Public and Private Subnets
* Internet Gateway
* NAT Gateway
* Application Load Balancer
* Auto Scaling Group
* IAM Roles
* S3 Backend for Terraform State
* Terraform Modules
* Remote State Management
* CI/CD using GitHub Actions
* AWS CloudWatch monitoring

## 👨‍💻 Author

**Anit Kumar Jha**

PHP / Laravel Developer → AWS & DevOps Engineer

### 📌 Tagline

> From Code to Cloud, We Automate the Journey.
