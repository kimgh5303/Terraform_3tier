provider "aws" {
  region  = var.region
}

# 모듈 정의
# 각 모듈에 있는 변수값은 child로 보내짐
# VPC
module "vpc" {
  source = "./modules/vpc"      # 모듈 코드가 위치한 경로 지정
    
  # Environment
  tags     = var.tags
  az_list = var.az_list

  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}