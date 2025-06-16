resource "aws_s3_bucket" "access_logs" {
  count = var.enable_alb_access_logs ? 1 : 0

  bucket = format("%s-lb-access-logs", local.stack_identifier)

  tags = merge(
    local.common_tags,
    {
      Name : format("%s-access-logs", local.stack_identifier),
    }
  )
}