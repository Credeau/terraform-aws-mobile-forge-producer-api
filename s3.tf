resource "random_string" "suffix" {
  length  = 6
  upper   = false
  lower   = true
  numeric = true
  special = false
}

resource "aws_s3_bucket" "access_logs" {
  count = var.enable_alb_access_logs ? 1 : 0

  bucket = format("%s-lb-access-logs-%s", local.stack_identifier, random_string.suffix.result)

  tags = merge(
    local.common_tags,
    {
      Name : format("%s-access-logs", local.stack_identifier),
    }
  )
}