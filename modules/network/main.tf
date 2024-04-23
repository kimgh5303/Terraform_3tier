resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    "name" = var.vpc.vpc_name
  }
}

resource "aws_subnet" "public" {
  for_each          = var.public_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value["cidr"]
  availability_zone = each.value["zone"]

  tags = merge(
    {
      Name = format(
        "%s-pub-sub-%s",
        var.name,
        element(split("_", each.key), 2)
      )
    },
    var.tags,
  )
}