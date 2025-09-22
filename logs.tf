resource "aws_cloudwatch_log_group" "main" {
  name              = format("%s-logs", local.stack_identifier)
  retention_in_days = var.logs_retention_period
  tags              = local.common_tags
}

resource "aws_cloudwatch_log_metric_filter" "producer_errors" {
  count = length(var.log_metric_filters)

  name  = format("%s-logs-errors-%s", local.stack_identifier, var.log_metric_filters[count.index].name)
  log_group_name = aws_cloudwatch_log_group.main.name
  pattern        = var.log_metric_filters[count.index].filter_pattern

  metric_transformation {
    name      = var.log_metric_filters[count.index].name
    namespace = local.metric_namespace
    value     = 1
  }
}

resource "aws_cloudwatch_log_group" "waf" {
  name              = format("aws-waf-logs-%s", local.stack_identifier) # waf needs this prefix before log group names `aws-waf-logs-`
  retention_in_days = var.logs_retention_period
  tags              = local.common_tags
}