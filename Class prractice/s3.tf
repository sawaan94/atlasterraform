resource "aws_s3_bucket" "tfbucket1" {
  bucket = var.bucket_name

}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfbuck" {
  bucket = aws_s3_bucket.tfbucket1.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}