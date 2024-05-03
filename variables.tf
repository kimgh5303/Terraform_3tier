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

# cidr_block 지정 -> "0.0.0.0/0"
variable "cidr_blocks" {}

# SG----------------------------------------------------
variable "ingress_rule" {}
variable "egress_rule" {}

# ALB----------------------------------------------------
variable "tg_set" {}
variable "health_checks" {
  type = map(object({
    path                 = string
    matcher              = string
    interval             = number
    timeout              = number
    healthy_threshold    = number
    unhealthy_threshold  = number
  }))
  description = "Health check settings for the load balancer target group"
}

variable "tg_web" {}
variable "tg_app" {}