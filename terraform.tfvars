region = "ap-northeast-2"

# 프로젝트 이름
name = "kgh"

vpc = {
  "vpc_name": "kgh-vpc"
  "vpc_cidr": "10.10.0.0/16"
}

az_names = [
  "ap-northeast-2a",
  "ap-northeast-2c"
]

public_subnets= {
  "subnet_name": "public-subnet-1"
  "subnet_cidr": "10.10.1.0/24"
  "az": "ap-northeast-2a"
  web_sub_2a = {
    zone = "ap-northeast-2a"
    cidr = "10.10.1.0/24"
  },
  web_sub_2c = {
    zone = "ap-northeast-2c"
    cidr = "10.10.2.0/24"
  }
}