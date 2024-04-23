provider "aws" {
  region  = var.region
}

# 모듈 정의
# VPC
module "network" {
  source = "./modules/network"      # 모듈 코드가 위치한 경로 지정
    
  # Environment
  name     = var.name
  tags     = var.tags
  az_names = var.az_names

  vpc_cidr        = var.vpc.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}