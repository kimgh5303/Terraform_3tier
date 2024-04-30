resource "aws_eip" "eip" {
  domain = "vpc"
}

resource "aws_eip" "eip2" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id     = aws_eip.eip.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.public_subnet1.id

  tags = {
    Name = format("%s-ngw1", var.tags["name"])
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat-gw2" {
  allocation_id     = aws_eip.eip2.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.public_subnet2.id

  tags = {
    Name = format("%s-ngw2", var.tags["name"])
  }

  depends_on = [aws_internet_gateway.igw]
}