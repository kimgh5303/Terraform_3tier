# web load balancer

resource "aws_lb" "web-alb" {
  load_balancer_type = var.web_alb.lb_type
  subnets            = [aws_subnet.web-subnet1.id, aws_subnet.web-subnet2.id]
  security_groups = [aws_security_group.alb-web-sg.id]

  tags = {
    Name = var.web_alb.name
  }
}

# was load balancer

resource "aws_lb" "was-alb" {
  internal           = true
  load_balancer_type = var.was_alb.lb_type
  subnets            = [aws_subnet.was-subnet1.id, aws_subnet.was-subnet2.id]
  security_groups = [aws_security_group.alb-was-sg.id]

  tags = {
    Name = var.was_alb.name
  }
}

# web listener

resource "aws_lb_listener" "web-alb-listener" {
  load_balancer_arn = aws_lb.web-alb.arn
  port              = var.web_alb_listener.port
  protocol          = var.web_alb_listener.protocol

  # By default, return a simple 404 page
  default_action {
    type = var.web_alb_listener.da_type

    fixed_response {
      content_type = var.web_alb_listener.fr_ct_type
      message_body = var.web_alb_listener.fr_ct_mb
      status_code  = var.web_alb_listener.fr_ct_sc
    }
  }
}

# was listener

resource "aws_lb_listener" "was-alb-listener" {
  load_balancer_arn = aws_lb.was-alb.arn
  port              = var.was_alb_listener.port
  protocol          = var.was_alb_listener.protocol

  # By default, return a simple 404 page
  default_action {
    type = var.was_alb_listener.da_type

    fixed_response {
      content_type = var.was_alb_listener.fr_ct_type
      message_body = var.was_alb_listener.fr_ct_mb
      status_code  = var.was_alb_listener.fr_ct_sc
    }
  }
}

# web target group

resource "aws_lb_target_group" "web-alb-tg" {
  name = var.web_alb_tg.name
  port     = var.web_alb_tg.port
  protocol = var.web_alb_tg.protocol
  vpc_id   = aws_vpc.my-vpc.id

  health_check {
    path                = var.web_alb_tg.hc_path
    protocol            = var.web_alb_tg.hc_protocol
    matcher             = var.web_alb_tg.hc_matcher
    interval            = var.web_alb_tg.hc_interval
    timeout             = var.web_alb_tg.hc_timeout
    healthy_threshold   = var.web_alb_tg.hc_ht
    unhealthy_threshold = var.web_alb_tg.hc_ut
  }
}

# was target group

resource "aws_lb_target_group" "was-alb-tg" {
  name = var.was_alb_tg.name
  port     = var.was_alb_tg.port
  protocol = var.was_alb_tg.protocol
  vpc_id   = aws_vpc.my-vpc.id

  health_check {
    path                = var.was_alb_tg.hc_path
    protocol            = var.was_alb_tg.hc_protocol
    matcher             = var.was_alb_tg.hc_matcher
    interval            = var.was_alb_tg.hc_interval
    timeout             = var.was_alb_tg.hc_timeout
    healthy_threshold   = var.was_alb_tg.hc_ht
    unhealthy_threshold = var.was_alb_tg.hc_ut
  }
}

# web listener rule

resource "aws_lb_listener_rule" "web-alb-rule" {
  listener_arn = aws_lb_listener.web-alb-listener.arn
  priority     = var.web_alb_rule.priority

  condition {
    path_pattern {
      values = var.web_alb_rule.con_pp_values
    }
  }

  action {
    type             = var.web_alb_rule.act_type
    target_group_arn = aws_lb_target_group.web-alb-tg.arn
  }
}

# was listener rule

resource "aws_lb_listener_rule" "was-alb-rule" {
  listener_arn = aws_lb_listener.was-alb-listener.arn
  priority     = var.was_alb_rule.priority

  condition {
    path_pattern {
      values = var.was_alb_rule.con_pp_values
    }
  }

  action {
    type             = var.was_alb_rule.act_type
    target_group_arn = aws_lb_target_group.was-alb-tg.arn
  }
}

output "web-alb-dns" {
  value       = aws_lb.web-alb.dns_name
  description = "The DNS Address of the ALB"
}

