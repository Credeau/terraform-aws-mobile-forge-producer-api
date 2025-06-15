resource "aws_cloudwatch_log_group" "main" {
  name              = format("%s-logs", local.stack_identifier)
  retention_in_days = var.logs_retention_period
  tags              = local.common_tags
}

resource "aws_cloudwatch_log_group" "waf" {
  name              = format("aws-waf-logs-%s", local.stack_identifier) # waf needs this prefix before log group names `aws-waf-logs-`
  retention_in_days = var.logs_retention_period
  tags              = local.common_tags
}