# 기본 환경 ----------------------------------------------
# Region
variable "region" {
  type    = string
}

# 공통 태그 이니셜
variable "tags" {
    type = string
    description = "사용 구분자 태그"
}

# VPC----------------------------------------------------
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
variable "private_subnets" {}

# VPC, Subnet ----------------------------------------------