resource "aws_s3_bucket" "remote-s3" {
  bucket = "clouddevops-bucket-s3"

  tags = {
    Name        = "clouddevops-bucket-s3"
    
  }
}