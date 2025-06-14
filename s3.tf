resource "aws_s3_bucket" "access_logs" {
  bucket = format("%s-lb-access-logs", local.stack_identifier)

  tags = merge(
    local.common_tags,
    {
      Name : format("%s-access-logs", local.stack_identifier),
    }
  )
}