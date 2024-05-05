# VPC 모듈
# VPC-------------------------------------------
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

<<<<<<< HEAD
#  tags = {
#    Name = format("%s-vpc", var.tags["name"])
#  }
=======
  tags = {
    Name = format("%s-vpc", var.tags["name"])
  }
>>>>>>> fa37f13087794dded7afc572e885b1daf1f85147
}