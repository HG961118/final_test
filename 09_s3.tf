resource "aws_s3_bucket" "final-s3-961118" {
  bucket = "final-s3-961118"
  acl    = "private"

  tags = {
    Name        = "final-s3-961118"
    Environment = "Dev"
  }
}

resource "aws_s3_access_point" "final-s3-access-point" {
  bucket = aws_s3_bucket.final-s3-961118.id
  name   = "final-s3-access-point"
}