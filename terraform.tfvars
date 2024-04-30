# 리전 정의
region = "us-west-1"

# 공통 태그 이니셜
tags = "owner:kgh"

# VPC----------------------------------------------------
az_list = [
  region+"a",
  region+"b"
]

vpc_cidr = "10.10.0.0/16"

# Public Subnets 정의
public_subnets = {
  web_sub_1a = {
    zone = az_lsit[0]
    cidr = "10.10.1.0/24"
  },
  web_sub_1b = {
    zone = az_lsit[1]
    cidr = "10.10.2.0/24"
  }
}

# private Subnets 정의
private_subnets = {
  app_sub_1a = {
    zone = az_lsit[0]
    cidr = "10.10.3.0/24"
  },
  app_sub_1b = {
    zone = az_lsit[1]
    cidr = "10.10.4.0/24"
  }
}