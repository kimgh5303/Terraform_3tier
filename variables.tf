# 기본 환경 ----------------------------------------------
# Region
variable "region" {
  type    = string
}

# 프로젝트 이름
variable "name" {
    type = string
    description = "이름 앞에 들어갈 프로젝트 구분"
}

# Tags
variable "tags" {
    description = "사용 구분자 태그"
}

# Availability Zones
variable "az_names" {
    type = list(string)
}

# VPC, Subnet ----------------------------------------------
# VPC
variable "vpc" {
    type = object({
        vpc_name = string
        vpc_cidr = string
    })
    description = "VPC 구성"
}

# Public Subnet list
variable "public_subnets" {}

# Private Subnet list
variable "private_subnets" {}