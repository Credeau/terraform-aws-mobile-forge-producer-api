resource "aws_cloudwatch_metric_alarm" "asg_cpu_upscale" {
  alarm_name          = format("%s-dynamic-upscale", local.stack_identifier)
  alarm_description   = "This metric alarm keeps a watch on CPU usage and triggers ASG upscale policy"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.upscale_evaluation_period
  statistic           = "Maximum"
  threshold           = var.scaling_cpu_threshold

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }

  alarm_actions = [
    aws_autoscaling_policy.upscale.arn,
    aws_sns_topic.alert_topic.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "asg_cpu_downscale" {
  alarm_name          = format("%s-dynamic-downscale", local.stack_identifier)
  alarm_description   = "This metric alarm keeps a watch on CPU usage and triggers ASG downscale policy"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 5
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.downscale_evaluation_period
  statistic           = "Maximum"
  threshold           = var.scaling_cpu_threshold

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }

  alarm_actions = [
    aws_autoscaling_policy.downscale.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "asg_memory_upscale" {
  alarm_name          = format("%s-asg-memory-warning", local.stack_identifier)
  alarm_description   = "This metric alarm keeps a watch on Memory usage and triggers ASG upscale policy"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = var.upscale_evaluation_period
  statistic           = "Maximum"
  threshold           = var.scaling_memory_threshold

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }

  alarm_actions = [
    aws_autoscaling_policy.upscale.arn,
    aws_sns_topic.alert_topic.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "asg_memory_downscale" {
  alarm_name          = format("%s-asg-memory-warning", local.stack_identifier)
  alarm_description   = "This metric alarm keeps a watch on Memory usage and triggers ASG downscale policy"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = var.downscale_evaluation_period
  statistic           = "Maximum"
  threshold           = var.scaling_memory_threshold

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }

  alarm_actions = [
    aws_autoscaling_policy.downscale.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "asg_disk" {
  alarm_name          = format("%s-asg-disk-warning", local.stack_identifier)
  alarm_description   = "This metric alarm keeps a watch on disk utilization of asg and send Email Notification"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = 60
  statistic           = "Average"
  threshold           = var.scaling_disk_threshold

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }

  alarm_actions = [
    aws_sns_topic.alert_topic.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "load_balancer_5XX" {
  alarm_name          = format("%s-alb-5XX-errors", local.stack_identifier)
  alarm_description   = "This metric alarm keeps a watch on error code of 5XXs in Load Balancer and send Email Notification"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Sum"
  threshold           = 2

  dimensions = {
    LoadBalancer = aws_lb.main.arn_suffix
  }

  alarm_actions = [
    aws_sns_topic.alert_topic.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "target_group_unhealthy_nodes" {
  alarm_name          = format("%s-tg-unhealthy-host", local.stack_identifier)
  alarm_description   = "This metric alarm keeps a watch on number of healthy nodes in Target Group and send Email Notification"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Maximum"
  threshold           = 1

  dimensions = {
    LoadBalancer = aws_lb.main.arn_suffix
    TargetGroup  = aws_lb_target_group.main.arn_suffix
  }

  alarm_actions = [
    aws_sns_topic.alert_topic.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "target_group_4XX" {
  alarm_name          = format("%s-tg-4XX-errors", local.stack_identifier)
  alarm_description   = "This metric alarm keeps a watch on error code of 4XXs in Target Group and send Email Notification"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "HTTPCode_Target_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Sum"
  threshold           = 2

  dimensions = {
    LoadBalancer = aws_lb.main.arn_suffix
    TargetGroup  = aws_lb_target_group.main.arn_suffix
  }

  alarm_actions = [
    aws_sns_topic.alert_topic.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "target_group_5XX" {
  alarm_name          = format("%s-tg-5XX-errors", local.stack_identifier)
  alarm_description   = "This metric alarm keeps a watch on error code of 5XXs in Target Group and send Email Notification"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Sum"
  threshold           = 2

  dimensions = {
    LoadBalancer = aws_lb.main.arn_suffix
    TargetGroup  = aws_lb_target_group.main.arn_suffix
  }

  alarm_actions = [
    aws_sns_topic.alert_topic.arn
  ]
}
