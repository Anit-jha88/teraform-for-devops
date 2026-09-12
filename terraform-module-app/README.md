## ☁️ Environment Infrastructure

### Development
- 1 EC2 instance (t2.micro)
- 1 S3 bucket
- Terraform Workspace: `dev`

### Staging
- 1 EC2 instance (t2.small)
- 1 S3 bucket
- Terraform Workspace: `stg`

### Production
- 2 EC2 instances (t2.medium)
- 1 S3 bucket
- 1 DynamoDB table
- Terraform Workspace: `prd`

## 🔄 Terraform Workspace Strategy

The project uses Terraform Workspaces to maintain isolated state files for each environment.

```bash
terraform workspace new dev
terraform workspace new stg
terraform workspace new prd
