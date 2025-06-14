resource "aws_wafv2_web_acl" "main" {
  name  = format("%s-lb-waf", local.stack_identifier)
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = format("%s-lb-waf-metric", local.stack_identifier)
    sampled_requests_enabled   = true
  }

  depends_on = [
    aws_lb.main
  ]

  rule {
    name     = "Custom-RateLimiting"
    priority = 0

    action {
      block {
        custom_response {
          response_code = 429
        }
      }
    }

    statement {
      rate_based_statement {
        limit              = var.waf_rate_limit
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "RateLimiting"
      sampled_requests_enabled   = true
    }
  }

  tags = merge(
    local.common_tags,
    {
      Name : format("%s-lb-waf", local.stack_identifier)
    }
  )
}

resource "aws_wafv2_web_acl_association" "main" {
  resource_arn = aws_lb.main.arn
  web_acl_arn  = aws_wafv2_web_acl.main.arn
}

resource "aws_wafv2_web_acl_logging_configuration" "main" {
  log_destination_configs = [aws_cloudwatch_log_group.waf.arn]
  resource_arn            = aws_wafv2_web_acl.main.arn
}