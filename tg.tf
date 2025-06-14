resource "aws_lb_target_group" "main" {
  name        = format("%s-tg", local.stack_identifier)
  port        = var.mapped_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    enabled             = true
    healthy_threshold   = 3         # count
    timeout             = 5         # seconds
    interval            = 10        # seconds
    matcher             = 200       # response status code
    path                = "/health" # api path
    protocol            = "HTTP"
    port                = "traffic-port"
    unhealthy_threshold = 5 # count
  }

  tags = merge(
    local.common_tags,
    {
      Name : format("%s-tg", local.stack_identifier)
    }
  )
}