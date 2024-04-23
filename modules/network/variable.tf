# root module에서 정의한 변수를 받아옴
# 프로젝트 이름
variable "name" {}

# VPC CIDR
variable "vpc" {
    type = object({
        vpc_name = string
        vpc_cidr = string
    })
    description = "VPC 구성"
}

# Availability Zones
variable "az_names" {}

# Public Subnet list
variable "public_subnets" {}

# Private Subnet list
variable "private_subnets" {}

# Tags
variable "tags" {}
