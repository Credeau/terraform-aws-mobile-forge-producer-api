resource "aws_lb" "main" {
  name               = format("%s-alb", local.stack_identifier)
  internal           = false
  idle_timeout       = var.api_timeout
  load_balancer_type = "application"
  security_groups    = concat(var.external_security_groups, var.internal_security_groups)
  subnets            = var.public_subnet_ids

  access_logs {
    bucket  = aws_s3_bucket.access_logs.id
    enabled = var.enable_alb_access_logs
  }

  tags = merge(
    local.common_tags,
    {
      Name : format("%s-alb", local.stack_identifier),
      ResourceType : "load-balancer",
    }
  )
}

resource "aws_lb_listener" "sdk_http" {
  load_balancer_arn = aws_lb.sdk_main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "403 Forbidden"
      status_code  = "403"
    }
  }
}

resource "aws_lb_listener" "sdk_https" {
  load_balancer_arn = aws_lb.sdk_main.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = data.aws_acm_certificate.main.arn

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "403 Forbidden"
      status_code  = "403"
    }
  }
}

resource "aws_lb_listener_rule" "sdk_http_rule" {
  listener_arn = aws_lb_listener.sdk_http.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sdk_main.arn
  }

  condition {
    path_pattern {
      values = local.allowed_api_paths
    }
  }
}

resource "aws_lb_listener_rule" "sdk_https_rule" {
  listener_arn = aws_lb_listener.sdk_https.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sdk_main.arn
  }

  condition {
    path_pattern {
      values = local.allowed_api_paths
    }
  }
}