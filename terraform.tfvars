# 리전 정의
region = "us-west-1"

# 공통 태그 이니셜
tags = {
  name = "owner:kgh"
}

# VPC----------------------------------------------------
az_list = [
  "us-west-1a",
  "us-west-1b"
]

vpc_cidr = "10.10.0.0/16"

# Public Subnets 정의
public_subnets = {
  pub_sub_1a = {
    zone = "us-west-1a"
    cidr = "10.10.1.0/24"
  },
  pub_sub_1b = {
    zone = "us-west-1b"
    cidr = "10.10.2.0/24"
  }
}

# Web Subnets 정의
web_subnets = {
  web_sub_1a = {
    zone = "us-west-1a"
    cidr = "10.10.3.0/24"
  },
  web_sub_1b = {
    zone = "us-west-1b"
    cidr = "10.10.4.0/24"
  }
}

# App Subnets 정의
app_subnets = {
  app_sub_1a = {
    zone = "us-west-1a"
    cidr = "10.10.5.0/24"
  },
  app_sub_1b = {
    zone = "us-west-1b"
    cidr = "10.10.6.0/24"
  }
}

# cidr_block 지정 -> "0.0.0.0/0"
cidr_blocks = "0.0.0.0/0"

# SG----------------------------------------------------
ingress_rule = {
  http = {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  https = {
    description = "HTTPS from Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ssh = {
    description = "SSH From Anywhere or Your-IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

egress_rule = {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

# ALB----------------------------------------------------
# Web, App health_check 
health_checks = {
  default = {
    path                 = "/"
    matcher              = "200-299"
    interval             = 5
    timeout              = 3
    healthy_threshold    = 3
    unhealthy_threshold  = 5
  }
}

tg_web = "tg-web"
tg_app = "tg-app"