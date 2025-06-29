resource "aws_lb" "main" {
  name               = format("%s-alb", local.stack_identifier)
  internal           = false
  idle_timeout       = var.api_timeout
  load_balancer_type = "application"
  security_groups    = concat(var.external_security_groups, var.internal_security_groups)
  subnets            = var.public_subnet_ids

  dynamic "access_logs" {
    for_each = var.enable_alb_access_logs ? [1] : []
    content {
      bucket  = aws_s3_bucket.access_logs[0].id
      enabled = true
    }
  }

  tags = merge(
    local.common_tags,
    {
      Name : format("%s-alb", local.stack_identifier),
      ResourceType : "load-balancer",
    }
  )
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
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

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
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

resource "aws_lb_listener_rule" "http_rule" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  condition {
    path_pattern {
      values = local.allowed_api_paths
    }
  }
}

resource "aws_lb_listener_rule" "https_rule" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  condition {
    path_pattern {
      values = local.allowed_api_paths
    }
  }
}