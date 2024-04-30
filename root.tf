provider "aws" {
  region  = var.region
}

# 모듈 정의 - variables.tf에 있는 변수명
# 각 모듈에 있는 변수값은 child로 보내짐
# VPC, Subnet, IGW, NGW
module "vpc" {
  source = "./modules/vpc"      # 모듈 코드가 위치한 경로 지정
    
  # Environment
  tags     = var.tags
  az_list = var.az_list

  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  web_subnets = var.web_subnets
  app_subnets = var.app_subnets
  rt_cidr_block = var.rt_cidr_block
}