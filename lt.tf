resource "aws_launch_template" "main" {
  name          = format("%s-lt", local.stack_identifier)
  instance_type = var.instance_type


  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = var.root_volume_size
      volume_type = "gp3"
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  # Note:
  # use this block only if public ip is required on instances
  # remember to use public subnets in var.subnet_ids
  # ---------------------------------------------------------
  network_interfaces {
    # associate_public_ip_address = true
    security_groups = var.internal_security_groups
  }

  # comment out if above is being used
  # vpc_security_group_ids = var.internal_security_groups

  ebs_optimized = true

  iam_instance_profile {
    arn = aws_iam_instance_profile.main.arn
  }

  image_id = var.ami_id

  key_name = var.key_name

  monitoring {
    enabled = true
  }

  user_data = base64encode(templatefile(
    "${path.module}/files/userdata.sh.tftpl",
    {
      region             = var.region
      registry           = local.ecr_registry
      ecr_repository     = var.ecr_repository
      image_tag          = var.ecr_image_tag
      application        = var.application
      mapped_port        = var.mapped_port
      application_port   = var.application_port
      postgres_user_name = var.postgres_user_name
      postgres_password  = var.postgres_password
      postgres_host      = var.postgres_host
      postgres_port      = var.postgres_port
      postgres_db        = var.postgres_db
      postgres_sync_db   = var.postgres_sync_db
      kafka_broker       = join(",", var.kafka_broker_hosts)
      log_group          = aws_cloudwatch_log_group.main.name
    }
  ))

  tags = merge(
    local.common_tags,
    {
      Name : format("%s-lt", local.stack_identifier)
    }
  )

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      local.common_tags,
      {
        Name : local.stack_identifier,
        ResourceType : "server"
      }
    )
  }

  tag_specifications {
    resource_type = "network-interface"

    tags = merge(
      local.common_tags,
      {
        Name : local.stack_identifier,
        ResourceType : "network"
      }
    )
  }

  tag_specifications {
    resource_type = "volume"

    tags = merge(
      local.common_tags,
      {
        Name : local.stack_identifier,
        ResourceType : "storage"
      }
    )
  }
}
