data "aws_ssm_parameter" "postgres_user_name" {
  name = "DUMMY_POSTGRES_USER"
  with_decryption = true
}

data "aws_ssm_parameter" "postgres_password" {
  name = "DUMMY_POSTGRES_PASSWORD"
  with_decryption = true
}

module "producer_api" {
  source = "git::https://github.com/credeau/terraform-aws-mobile-forge-producer-api.git?ref=v1.0.0"

  application             = "di-producer-api"
  environment             = "prod"
  region                  = "ap-south-1"
  certificate_domain_name = "*.credeau.com"
  stack_owner             = "tech@credeau.com"
  stack_team              = "devops"
  organization            = "credeau"
  alert_email_recipients  = []

  instance_type                  = "t3a.medium"
  ecr_repository                 = "mobile-forge-producer-api"
  ecr_image_tag                  = "0.7.1"
  root_volume_size               = 20
  ami_id                         = "ami-00000000000000000"
  key_name                       = "mobile-forge-demo"
  asg_min_size                   = 1
  asg_max_size                   = 2
  asg_desired_size               = 1
  upscale_evaluation_period      = 60
  downscale_evaluation_period    = 300
  logs_retention_period          = 7
  api_timeout                    = 60
  scaling_cpu_threshold          = 55
  scaling_memory_threshold       = 55
  scaling_disk_threshold         = 70
  mapped_port                    = 8000
  application_port               = 8000
  enable_scheduled_scaling       = true
  timezone                       = "Asia/Kolkata"
  upscale_schedule               = "0 8 * * MON-SUN"
  scheduled_upscale_min_size     = 2
  scheduled_upscale_max_size     = 5
  scheduled_upscale_desired_size = 2
  downscale_schedule             = "0 21 * * MON-SUN"
  enable_alb_access_logs         = false

  vpc_id = "vpc-00000000000000000"
  private_subnet_ids = [
    "subnet-00000000000000000",
    "subnet-00000000000000000",
  ]
  public_subnet_ids = [
    "subnet-00000000000000000",
    "subnet-00000000000000000",
  ]
  internal_security_groups = ["sg-00000000000000000"]
  external_security_groups = ["sg-00000000000000000"]
  waf_rate_limit           = 100

  kafka_broker_hosts = [format("%s:9092", module.kafka.host_address)]
  postgres_user_name = data.aws_ssm_parameter.postgres_user_name.value
  postgres_password  = data.aws_ssm_parameter.postgres_password.value
  postgres_host      = aws_db_instance.postgres.db_name
  postgres_port      = 5432
  postgres_db        = "api_insights_db"
}
