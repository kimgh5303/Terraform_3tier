resource "aws_route_table" "private_rt1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.rt_cidr_block
    gateway_id = aws_nat_gateway.ngw1.id
  }

  tags = {
    Name = format("%s-pri-rt1", var.tags["name"])
  }
}

resource "aws_route_table" "private_rt2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.rt_cidr_block
    gateway_id = aws_nat_gateway.ngw2.id
  }

  tags = {
    Name = format("%s-pri-rt2", var.tags["name"])
  }
}

# WEB
resource "aws_route_table_association" "pri-rt-asscociation-1" {
  subnet_id      = aws_subnet.web-subnet1.id
  route_table_id = aws_route_table.private-route-table1.id
}

resource "aws_route_table_association" "pri-rt-asscociation-2" {
  subnet_id      = aws_subnet.web-subnet2.id
  route_table_id = aws_route_table.private-route-table2.id
}

# WAS
resource "aws_route_table_association" "pri-rt-asscociation-3" {
  subnet_id      = aws_subnet.app_subnet1.id
  route_table_id = aws_route_table.private-route-table1.id
}

resource "aws_route_table_association" "pri-rt-asscociation-4" {
  subnet_id      = aws_subnet.app-subnet2.id
  route_table_id = aws_route_table.private-route-table2.id
}