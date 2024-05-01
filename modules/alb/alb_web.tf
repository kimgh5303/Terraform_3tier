resource "aws_lb" "alb_web" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_web_sg]
  subnets            = [var.public_subnet_ids["pub_sub_1a"],
                        var.public_subnet_ids["pub_sub_1b"]]

  tags = {
    Name = format("%s-alb-web", var.tags["name"])
  }
}