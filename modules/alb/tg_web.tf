resource "aws_lb_target_group" "tg_web" {
  name     = "tg-web"
  port     = var.tg_set["port"]
  protocol = var.tg_set["protocol"]
  vpc_id   = var.vpc_id

  dynamic "health_check" {
    for_each = var.health_checks

    content {
      path                 = health_check.value.path
      matcher              = health_check.value.matcher
      interval             = health_check.value.interval
      timeout              = health_check.value.timeout
      healthy_threshold    = health_check.value.healthy_threshold
      unhealthy_threshold  = health_check.value.unhealthy_threshold
    }
  }
}