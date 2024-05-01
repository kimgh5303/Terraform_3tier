resource "aws_lb" "alb_app" {
  name               = "app-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.alb_app_sg]
  subnets            = [var.app_subnet_ids["app_sub_1a"],
                        var.app_subnet_ids["app_sub_1b"]]

  tags = {
    Name = format("%s-alb-app", var.tags["name"])
  }
}