provider "aws" {
  region  = var.region
}

# VPC

resource "aws_vpc" "my-vpc" {
  cidr_block       = var.vpc.cidr
  enable_dns_support   = var.vpc.eds
  enable_dns_hostnames = var.vpc.edh

  tags = {
    Name = var.vpc.vpc_name
  }
}

# public subnets

# web subnet 1
resource "aws_subnet" "web-subnet1" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.web_subnet_1.cidr
  map_public_ip_on_launch = var.web_subnet_1.mpiol

  availability_zone = var.web_subnet_1.az

  tags = {
    Name = var.web_subnet_1.subnet_name
  }
}
# web subnet 2
resource "aws_subnet" "web-subnet2" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.web_subnet_2.cidr
  map_public_ip_on_launch = var.web_subnet_1.mpiol

  availability_zone = var.web_subnet_2.az

  tags = {
    Name = var.web_subnet_2.subnet_name
  }
}

# private subnets

# was subnet 1
resource "aws_subnet" "was-subnet1" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.was_subnet_1.cidr

  availability_zone = var.was_subnet_1.az

  tags = {
    Name = var.was_subnet_1.subnet_name
  }
}
# was subnet 2
resource "aws_subnet" "was-subnet2" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.was_subnet_2.cidr

  availability_zone = var.was_subnet_2.az

  tags = {
    Name = var.was_subnet_2.subnet_name
  }
}

# db subnet 1
resource "aws_subnet" "db-subnet1" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.db_subnet_1.cidr

  availability_zone = var.db_subnet_1.az

  tags = {
    Name = var.db_subnet_1.subnet_name
  }
}
# db subnet 2
resource "aws_subnet" "db-subnet2" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.db_subnet_2.cidr

  availability_zone = var.db_subnet_2.az

  tags = {
    Name = var.db_subnet_2.subnet_name
  }
}

# db subnet group
resource "aws_db_subnet_group" "db-subnet-group" {
  name       = var.db-subnet-grp-name
  subnet_ids = [aws_subnet.db-subnet1.id, aws_subnet.db-subnet2.id]
}

# Internet Gateway

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = var.igw_name
  }
}

# elastic IP address

resource "aws_eip" "eip-address" {
    domain     = "vpc"   
}

# Nat Gateway

resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.eip-address.id
  subnet_id     = aws_subnet.was-subnet1.id

  tags = {
    Name = var.nat-gw-name
  }

  depends_on = [aws_internet_gateway.my-igw]
}

# public Route Table

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = var.public_rt_name
  }
}
resource "aws_route_table_association" "public-rt-association1" {
  subnet_id      = aws_subnet.web-subnet1.id
  route_table_id = aws_route_table.public-rt.id
}
resource "aws_route_table_association" "public-rt-association2" {
  subnet_id      = aws_subnet.web-subnet2.id
  route_table_id = aws_route_table.public-rt.id
}
resource "aws_route" "my-defaultroute" {
  route_table_id         = aws_route_table.public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my-igw.id
}

# private route table

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway.id
  }

   tags = {
    Name = var.private_rt_name
  }
}
resource "aws_route_table_association" "private-rt-association1" {
  subnet_id      = aws_subnet.was-subnet1.id
  route_table_id = aws_route_table.private-rt.id
}
resource "aws_route_table_association" "private-rt-association2" {
  subnet_id      = aws_subnet.was-subnet2.id
  route_table_id = aws_route_table.private-rt.id
}