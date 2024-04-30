# root module에서 정의한 변수를 받아옴
# 공통 태그 이니셜 -> kgh
variable "tags" {}

# 가용 영역
variable "az_list" {}

# vpc_cidr
variable "vpc_cidr" {}

# Public Subnet list
variable "public_subnets" {}

# Private Subnet list
variable "web_subnets" {}
variable "app_subnets" {}

# public route table cidr_block
variable "rt_cidr_block" {}