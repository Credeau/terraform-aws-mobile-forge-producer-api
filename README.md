<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, < 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_policy.downscale](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_autoscaling_policy.upscale](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_autoscaling_schedule.scheduled_downscale](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_schedule) | resource |
| [aws_autoscaling_schedule.scheduled_upscale](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_schedule) | resource |
| [aws_cloudwatch_log_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.waf](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_metric_alarm.asg_cpu_downscale](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.asg_cpu_upscale](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.asg_disk](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.asg_memory_downscale](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.asg_memory_upscale](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.load_balancer_5XX](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.target_group_4XX](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.target_group_5XX](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.target_group_unhealthy_nodes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_iam_instance_profile.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.consumer_scale_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.consumer_scale_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.ssh_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_launch_template.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_lb.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener_rule.http_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.https_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_placement_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/placement_group) | resource |
| [aws_s3_bucket.access_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_sns_topic.alert_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.email_subscriptions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_wafv2_web_acl.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |
| [aws_wafv2_web_acl_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_association) | resource |
| [aws_wafv2_web_acl_logging_configuration.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_logging_configuration) | resource |
| [aws_acm_certificate.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alert_email_recipients"></a> [alert\_email\_recipients](#input\_alert\_email\_recipients) | email recipients for sns alerts | `list(string)` | `[]` | no |
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | ami to use for instances | `string` | n/a | yes |
| <a name="input_api_timeout"></a> [api\_timeout](#input\_api\_timeout) | api timeout | `number` | `60` | no |
| <a name="input_application"></a> [application](#input\_application) | application name to refer and mnark across the module | `string` | `"di-producer-api"` | no |
| <a name="input_application_port"></a> [application\_port](#input\_application\_port) | application port to run the application | `number` | `8000` | no |
| <a name="input_asg_desired_size"></a> [asg\_desired\_size](#input\_asg\_desired\_size) | number of instances to provision for producer | `number` | `1` | no |
| <a name="input_asg_max_size"></a> [asg\_max\_size](#input\_asg\_max\_size) | maximum number of instances to keep in asg for producer | `number` | `2` | no |
| <a name="input_asg_min_size"></a> [asg\_min\_size](#input\_asg\_min\_size) | minimum number of instances to keep in asg for producer | `number` | `1` | no |
| <a name="input_certificate_domain_name"></a> [certificate\_domain\_name](#input\_certificate\_domain\_name) | domain name of the acm certificate for https | `string` | `"*.credeau.com"` | no |
| <a name="input_downscale_evaluation_period"></a> [downscale\_evaluation\_period](#input\_downscale\_evaluation\_period) | Number of seconds required to observe the system before triggering downscale | `number` | `300` | no |
| <a name="input_downscale_schedule"></a> [downscale\_schedule](#input\_downscale\_schedule) | downscale schedule | `string` | `"0 21 * * MON-SUN"` | no |
| <a name="input_ecr_image_tag"></a> [ecr\_image\_tag](#input\_ecr\_image\_tag) | aws sync ecr repository image tag | `string` | `"latest"` | no |
| <a name="input_ecr_repository"></a> [ecr\_repository](#input\_ecr\_repository) | aws sync ecr repository | `string` | `"device-insights-producer-api"` | no |
| <a name="input_enable_alb_access_logs"></a> [enable\_alb\_access\_logs](#input\_enable\_alb\_access\_logs) | enable alb access logs | `bool` | `false` | no |
| <a name="input_enable_scheduled_scaling"></a> [enable\_scheduled\_scaling](#input\_enable\_scheduled\_scaling) | enable scheduled scaling | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | environment type | `string` | `"dev"` | no |
| <a name="input_external_security_groups"></a> [external\_security\_groups](#input\_external\_security\_groups) | list of external access security group ids | `list(string)` | `[]` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instances type to provision in ASG for producer | `string` | `"t2.micro"` | no |
| <a name="input_internal_security_groups"></a> [internal\_security\_groups](#input\_internal\_security\_groups) | list of internal access security group ids | `list(string)` | `[]` | no |
| <a name="input_kafka_broker_hosts"></a> [kafka\_broker\_hosts](#input\_kafka\_broker\_hosts) | kafka broker hosts | `list(string)` | `[]` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | ssh access key name | `string` | n/a | yes |
| <a name="input_logs_retention_period"></a> [logs\_retention\_period](#input\_logs\_retention\_period) | No of days to retain the logs | `number` | `7` | no |
| <a name="input_mapped_port"></a> [mapped\_port](#input\_mapped\_port) | mapped port to expose the application | `number` | `8000` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | organization name | `string` | `"credeau"` | no |
| <a name="input_postgres_db"></a> [postgres\_db](#input\_postgres\_db) | postgres main database | `string` | `null` | no |
| <a name="input_postgres_host"></a> [postgres\_host](#input\_postgres\_host) | postgres host | `string` | `null` | no |
| <a name="input_postgres_password"></a> [postgres\_password](#input\_postgres\_password) | postgres user password | `string` | `null` | no |
| <a name="input_postgres_port"></a> [postgres\_port](#input\_postgres\_port) | postgres port | `number` | `5432` | no |
| <a name="input_postgres_sync_db"></a> [postgres\_sync\_db](#input\_postgres\_sync\_db) | postgres sync database | `string` | `null` | no |
| <a name="input_postgres_user_name"></a> [postgres\_user\_name](#input\_postgres\_user\_name) | postgres user name | `string` | `null` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | list of private subnet ids to use | `list(string)` | n/a | yes |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | list of public subnet ids to use | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | aws region to use | `string` | `"ap-south-1"` | no |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | size of root volume in GiB | `number` | `20` | no |
| <a name="input_scaling_cpu_threshold"></a> [scaling\_cpu\_threshold](#input\_scaling\_cpu\_threshold) | CPU utilization % threshold for scaling & alerting | `number` | `65` | no |
| <a name="input_scaling_disk_threshold"></a> [scaling\_disk\_threshold](#input\_scaling\_disk\_threshold) | Disk utilization % threshold for scaling & alerting | `number` | `80` | no |
| <a name="input_scaling_memory_threshold"></a> [scaling\_memory\_threshold](#input\_scaling\_memory\_threshold) | Memory utilization % threshold for scaling & alerting | `number` | `60` | no |
| <a name="input_scheduled_upscale_desired_size"></a> [scheduled\_upscale\_desired\_size](#input\_scheduled\_upscale\_desired\_size) | desired number of instances to keep in asg for scheduled upscale | `number` | `5` | no |
| <a name="input_scheduled_upscale_max_size"></a> [scheduled\_upscale\_max\_size](#input\_scheduled\_upscale\_max\_size) | maximum number of instances to keep in asg for scheduled upscale | `number` | `10` | no |
| <a name="input_scheduled_upscale_min_size"></a> [scheduled\_upscale\_min\_size](#input\_scheduled\_upscale\_min\_size) | minimum number of instances to keep in asg for scheduled upscale | `number` | `5` | no |
| <a name="input_stack_owner"></a> [stack\_owner](#input\_stack\_owner) | owner of the stack | `string` | `"tech@credeau.com"` | no |
| <a name="input_stack_team"></a> [stack\_team](#input\_stack\_team) | team of the stack | `string` | `"devops"` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | timezone to use for scheduled scaling | `string` | `"Asia/Kolkata"` | no |
| <a name="input_upscale_evaluation_period"></a> [upscale\_evaluation\_period](#input\_upscale\_evaluation\_period) | Number of seconds required to observe the system before triggering upscale | `number` | `60` | no |
| <a name="input_upscale_schedule"></a> [upscale\_schedule](#input\_upscale\_schedule) | upscale schedule | `string` | `"0 8 * * MON-SUN"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | vpc id | `string` | n/a | yes |
| <a name="input_waf_rate_limit"></a> [waf\_rate\_limit](#input\_waf\_rate\_limit) | number of requests to allow from same IP in 1 min span on LB | `number` | `100` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_access_log_bucket"></a> [alb\_access\_log\_bucket](#output\_alb\_access\_log\_bucket) | ALB Access Log Bucket |
| <a name="output_asg_name"></a> [asg\_name](#output\_asg\_name) | Auto Scaling Group Name |
| <a name="output_lb_dns_name"></a> [lb\_dns\_name](#output\_lb\_dns\_name) | Load Balancer DNS Name |
<!-- END_TF_DOCS -->