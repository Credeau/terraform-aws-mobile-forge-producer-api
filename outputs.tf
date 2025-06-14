# Load Balancer DNS Name
output "lb_dns_name" {
  value = aws_lb.main.dns_name
}

# Auto Scaling Group Name
output "asg_name" {
  value = aws_autoscaling_group.main.name
}

# ALB Access Log Bucket
output "alb_access_log_bucket" {
  value = aws_s3_bucket.access_logs.bucket
}