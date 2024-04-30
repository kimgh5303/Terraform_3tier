# VPC 모듈
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    name = var.tags
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  for_each          = var.public_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value["cidr"]
  availability_zone = each.value["zone"]

  tags = merge(
    {
      Name = format(
        "%s-pub-sub-%s",
        var.tags,
        element(split("_", each.key), 2)
      )
    },
    var.tags,
  )
}

# Private Subnets
resource "aws_subnet" "private" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value["cidr"]
  availability_zone = each.value["zone"]

  tags = merge(
    {
      Name = format(
        "%s-pri-sub-%s",
        var.tags,
        element(split("_", each.key), 2)
      )
    },
    var.tags,
  )
}