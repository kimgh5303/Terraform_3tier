# 기본 환경 ----------------------------------------------
# Region
variable "region" {
  type    = string
}

# 공통 태그 이니셜
variable "tags" {
    type = map(string)
    description = "사용 구분자 태그"
}

# VPC----------------------------------------------------
# VPC, Subnet, IGW, NGW
# 가용 영역
variable "az_list" {
    type = list(string)
}
# VPC CIDR
variable "vpc_cidr" {
    type = string
    description = "VPC 구성"
}

# Public Subnet 목록
variable "public_subnets" {}

# Private Subnet 목록
variable "web_subnets" {}
variable "app_subnets" {}

# route table cidr_block -> "0.0.0.0/0"
variable "rt_cidr_block" {}