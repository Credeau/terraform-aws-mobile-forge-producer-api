data "aws_caller_identity" "current" {}

data "aws_acm_certificate" "main" {
  domain   = var.certificate_domain_name
  statuses = ["ISSUED"]
}