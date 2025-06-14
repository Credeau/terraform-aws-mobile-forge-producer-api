resource "aws_autoscaling_group" "main" {
  name            = local.stack_identifier
  placement_group = aws_placement_group.main.id

  min_size         = var.asg_min_size
  desired_capacity = var.asg_desired_size
  max_size         = var.asg_max_size

  default_cooldown          = 60  # seconds
  health_check_grace_period = 120 # seconds
  health_check_type         = "EC2"
  vpc_zone_identifier       = var.private_subnet_ids
  termination_policies      = ["OldestInstance"]
  metrics_granularity       = "1Minute"
  target_group_arns         = [aws_lb_target_group.main.arn]

  launch_template {
    id      = aws_launch_template.main.id
    version = aws_launch_template.main.latest_version
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      checkpoint_percentages = [50, 100]
      min_healthy_percentage = 50
      checkpoint_delay       = 120
    }
  }

  # propagate_at_launch is false as instance and volume tags are specified in Launch Template
  tag {
    key                 = "Name"
    value               = local.stack_identifier
    propagate_at_launch = false
  }

  tag {
    key                 = "ResourceType"
    value               = "server"
    propagate_at_launch = false
  }

  dynamic "tag" {
    for_each = local.common_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = false
    }
  }
}

resource "aws_autoscaling_schedule" "scheduled_upscale" {
  count = var.enable_scheduled_scaling ? 1 : 0

  scheduled_action_name  = format("%s-scheduled-upscale-action", local.stack_identifier)
  min_size               = var.scheduled_upscale_min_size
  max_size               = var.scheduled_upscale_max_size
  desired_capacity       = var.scheduled_upscale_desired_size
  autoscaling_group_name = aws_autoscaling_group.main.name
  time_zone              = var.timezone
  recurrence             = var.upscale_schedule
}

resource "aws_autoscaling_schedule" "scheduled_downscale" {
  count = var.enable_scheduled_scaling ? 1 : 0

  scheduled_action_name  = format("%s-scheduled-downscale-action", local.stack_identifier)
  min_size               = var.asg_min_size
  max_size               = var.asg_max_size
  desired_capacity       = var.asg_desired_size
  autoscaling_group_name = aws_autoscaling_group.main.name
  time_zone              = var.timezone
  recurrence             = var.downscale_schedule
}

resource "aws_autoscaling_policy" "upscale" {
  name                   = format("%s-upscale-policy", local.stack_identifier)
  scaling_adjustment     = 2 # number of servers to add once triggered
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60 # seconds
  autoscaling_group_name = aws_autoscaling_group.main.name
}

resource "aws_autoscaling_policy" "downscale" {
  name                   = format("%s-downscale-policy", local.stack_identifier)
  scaling_adjustment     = -1 # number of servers to add once triggered
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300 # seconds
  autoscaling_group_name = aws_autoscaling_group.main.name
}
