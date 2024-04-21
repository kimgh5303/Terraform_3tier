# alb web security group

resource "aws_security_group" "alb-web-sg" {
  vpc_id      = aws_vpc.my-vpc.id
  name        = var.alb_web_sg.name
  description = var.alb_web_sg.description

  tags = {
    Name = var.alb_web_sg.name
  }
}
resource "aws_security_group_rule" "alb_web-sg-inbound" {
  type              = var.alb_web_sg_inbound.type
  from_port         = var.alb_web_sg_inbound.from_port
  to_port           = var.alb_web_sg_inbound.to_port
  protocol          = var.alb_web_sg_inbound.protocol
  cidr_blocks       = var.alb_web_sg_inbound.cidr_blocks
  security_group_id = aws_security_group.alb-web-sg.id
}
resource "aws_security_group_rule" "alb_web-sg-outbound" {
  type              = var.alb_web_sg_outbound.type
  from_port         = var.alb_web_sg_outbound.from_port
  to_port           = var.alb_web_sg_outbound.to_port
  protocol          = var.alb_web_sg_outbound.protocol
  cidr_blocks       = var.alb_web_sg_outbound.cidr_blocks
  security_group_id = aws_security_group.alb-web-sg.id
}

# alb was security group

resource "aws_security_group" "alb-was-sg" {
  name        = var.alb_was_sg.name
  description = var.alb_was_sg.desc
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description = var.alb_was_sg.i_desc
    from_port   = var.alb_was_sg.i_from_port
    to_port     = var.alb_was_sg.i_to_port
    protocol    = var.alb_was_sg.i_protocol
    security_groups = [aws_security_group.asg-web-sg.id]
  }

  egress {
    from_port   = var.alb_was_sg.e_from_port
    to_port     = var.alb_was_sg.e_to_port
    protocol    = var.alb_was_sg.e_protocol
    cidr_blocks = var.alb_was_sg.e_cidr
  }

  tags = {
    Name = var.alb_was_sg.name
  }
}

# db security group

resource "aws_security_group" "db-sg" {
  name        = var.db_sg.name
  description = var.db_sg.desc
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    from_port   = var.db_sg.i_from_port
    to_port     = var.db_sg.i_to_port
    protocol    = var.db_sg.i_protocol
    security_groups = [aws_security_group.asg-was-sg.id]   
  }

  egress {
    from_port   = var.db_sg.e_from_port
    to_port     = var.db_sg.e_to_port
    protocol    = var.db_sg.e_protocol
    cidr_blocks = var.db_sg.e_cidr
  }

  tags = {
    Name = var.db_sg.name
  }
}

# asg web security group

resource "aws_security_group" "asg-web-sg" {
  name        = var.asg_web_sg.name
  description = var.asg_web_sg.desc
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description = var.asg_web_sg.i_desc
    from_port   = var.asg_web_sg.i_from_port
    to_port     = var.asg_web_sg.i_to_port
    protocol    = var.asg_web_sg.i_protocol
    security_groups = [aws_security_group.alb-web-sg.id]
  }
  ingress {
    description = var.asg_web_sg.i_desc
    from_port   = var.asg_web_sg.i_from_port
    to_port     = var.asg_web_sg.i_to_port
    protocol    = var.asg_web_sg.i_protocol
    cidr_blocks = var.asg_web_sg.e_cidr
  }

  egress {
    from_port   = var.asg_web_sg.e_from_port
    to_port     = var.asg_web_sg.e_to_port
    protocol    = var.asg_web_sg.e_protocol
    cidr_blocks = var.asg_web_sg.e_cidr
  }

  tags = {
    Name = var.asg_web_sg.name
  }
}

# asg was security group

resource "aws_security_group" "asg-was-sg" {
  name        = var.asg_was_sg.name
  description = var.asg_was_sg.desc
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description = var.asg_was_sg.i_desc
    from_port   = var.asg_was_sg.i_from_port
    to_port     = var.asg_was_sg.i_to_port
    protocol    = var.asg_was_sg.i_protocol
    security_groups = [aws_security_group.alb-was-sg.id]
  }
  ingress {
    description = var.asg_was_sg.i_desc
    from_port   = var.asg_was_sg.i_from_port
    to_port     = var.asg_was_sg.i_to_port
    protocol    = var.asg_was_sg.i_protocol
    security_groups = [aws_security_group.alb-web-sg.id]
  }

  egress {
    from_port   = var.asg_was_sg.e_from_port
    to_port     = var.asg_was_sg.e_to_port
    protocol    = var.asg_was_sg.e_protocol
    cidr_blocks = var.asg_was_sg.e_cidr
  }

  tags = {
    Name = var.asg_was_sg.name
  }
}