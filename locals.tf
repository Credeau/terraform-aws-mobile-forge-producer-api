locals {
  common_tags = {
    Stage    = var.environment
    Owner    = var.stack_owner
    Team     = var.stack_team
    Pipeline = var.application
    Org      = var.organization
  }

  ecr_registry     = format("%s.dkr.ecr.%s.amazonaws.com", data.aws_caller_identity.current.account_id, var.region)
  stack_identifier = format("%s-%s", var.application, var.environment)
  allowed_api_paths = [
    "/api/sync_sms",
    "/api/sync_device",
    "/api/sync_contacts",
    "/api/sync_call_logs",
    "/api/sync_web"
  ]
}