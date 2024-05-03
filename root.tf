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
  rt_cidr_blocks = var.cidr_blocks
}

module "sg" {
  source = "./modules/sg"
  tags     = var.tags
  vpc_id   = module.vpc.vpc_id

  ingress_rule = var.ingress_rule
  egress_rule = var.egress_rule
}

module "alb" {
  source = "./modules/alb"
  tags     = var.tags
  vpc_id   = module.vpc.vpc_id

  alb_web_sg = module.sg.alb_web_sg
  alb_app_sg = module.sg.alb_app_sg
  public_subnet_ids = module.vpc.public_subnet_ids
  app_subnet_ids = module.vpc.app_subnet_ids

  tg_set = var.tg_set
  health_checks = var.health_checks
  tg_web = var.tg_web
  tg_app = var.tg_app
}