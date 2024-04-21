# VPC----------------------------------------

region = "ap-northeast-2"

vpc = {
  "vpc_name": "mzcloud",
  "cidr": "10.10.0.0/16",
  "eds": "true",
  "edh": "true"
}

web_subnet_1 = {
  "subnet_name": "web-subnet1",
  "cidr": "10.10.1.0/24",
  "az": "ap-northeast-2a",
  "mpiol": true
}

web_subnet_2 = {
  "subnet_name": "web-subnet2",
  "cidr": "10.10.2.0/24",
  "az": "ap-northeast-2c",
  "mpiol": true
}

was_subnet_1 = {
  "subnet_name": "was-subnet1",
  "cidr": "10.10.3.0/24",
  "az": "ap-northeast-2a",
}

was_subnet_2 = {
  "subnet_name": "was-subnet2",
  "cidr": "10.10.4.0/24",
  "az": "ap-northeast-2c",
}

db_subnet_1 = {
  "subnet_name": "db-subnet1",
  "cidr": "10.10.5.0/24",
  "az": "ap-northeast-2a",
}

db_subnet_2 = {
  "subnet_name": "db-subnet2",
  "cidr": "10.10.6.0/24",
  "az": "ap-northeast-2c",
}

igw_name = "mzc-igw"
nat-gw-name = "3-tier-natgw"

public_rt_name = "pub-rt"

private_rt_name =  "pri-rt"

db-subnet-grp-name = "dbsubnetgrp"

# SG----------------------------------------

alb_web_sg = {
  "name": "web SG"
  "description": "3tier web SG"
}

alb_web_sg_inbound = {
  "type": "ingress"
  "from_port": 0
  "to_port": 80
  "protocol": "tcp"
  "cidr_blocks": ["0.0.0.0/0"]
}

alb_web_sg_outbound = {
  "type": "egress"
  "from_port": 0
  "to_port": 0
  "protocol": "-1"
  "cidr_blocks": ["0.0.0.0/0"]
}

alb_was_sg = {
  "name": "was SG"
  "desc": "3tier was SG"
  "i_desc": "http from internet"
  "i_from_port": 8080
  "i_to_port": 8080
  "i_protocol": "tcp"
  "e_from_port": 0
  "e_to_port": 0
  "e_protocol": "-1"
  "e_cidr": ["0.0.0.0/0"]
}

db_sg = {
  "name": "db SG"
  "desc": "3tier db SG"
  "i_from_port": 3306
  "i_to_port": 3306
  "i_protocol": "tcp"
  "e_from_port": 0
  "e_to_port": 0
  "e_protocol": "-1"
  "e_cidr": ["0.0.0.0/0"]
}

asg_web_sg = {
  "name": "3tier-web-asg-sg"
  "desc": "3tier web asg SG"
  "i_desc": "http from alb"
  "i_from_port": 80
  "i_to_port": 80
  "i_protocol": "tcp"
  "i2_desc": "SSH from anywhere"
  "i2_from_port": 22
  "i2_to_port": 22
  "i2_protocol": "tcp"
  "i2_cidr": ["0.0.0.0/0"]
  "e_from_port": 0
  "e_to_port": 0
  "e_protocol": "-1"
  "e_cidr": ["0.0.0.0/0"]
}

asg_was_sg = {
  "name": "3tier-was-asg-sg"
  "desc": "3tier was asg SG"
  "i_desc": "http from alb"
  "i_from_port": 80
  "i_to_port": 80
  "i_protocol": "tcp"
  "i2_desc": "SSH from anywhere"
  "i2_from_port": 22
  "i2_to_port": 22
  "i2_protocol": "tcp"
  "e_from_port": 0
  "e_to_port": 0
  "e_protocol": "-1"
  "e_cidr": ["0.0.0.0/0"]
}

# ASG---------------------------------
my_amazonlinux2 = {
    "most_recent" : true
    "fil_1_name" : "owner-alias"
    "fil_1_values" : ["amazon"]
    "fil_2_name" : "name"
    "fil_2_values" : ["amzn2-ami-hvm-*-x86_64-ebs"]
    "owners" : ["amazon"]
}

web_launch_template = {
  "name_prefix" : "web-cloud-"
  "instance_type" : "t2.micro"
  "associate_public_ip_address" : true
  "create_before_destroy" : true
}

was_launch_template = {
  "name_prefix" : "was-cloud-"
  "instance_type" : "t2.micro"
  "create_before_destroy" : true
}

web_asg = {
  "name" : "web-asg"
  "min_size" : 2
  "max_size" : 4
  "health_check_type" : "ELB"
  "key" : "Name"
  "value" : "terraform-web"
  "propagate_at_launch" : true
}

was_asg = {
  "name" : "was-asg"
  "min_size" : 2
  "max_size" : 4
  "health_check_type" : "ELB"
  "key" : "Name"
  "value" : "terraform-was"
  "propagate_at_launch" : true
}

# ALB---------------------------------

web_alb = {
  "name": "web-alb"
  "lb_type": "application"
}

was_alb = {
  "name": "was-alb"
  "lb_type": "application"
}

web_alb_listener = {
  "port": 80
  "protocol": "HTTP"
  "da_type": "fixed-response"
  "fr_ct_type": "text/plain"
  "fr_ct_mb": "404: page not found - BABO"
  "fr_ct_sc": 404
}

was_alb_listener = {
  "port": 8080
  "protocol": "HTTP"
  "da_type": "fixed-response"
  "fr_ct_type": "text/plain"
  "fr_ct_mb": "404: page not found - BABO"
  "fr_ct_sc": 404
}

web_alb_tg = {
  "name": "web-alb-tg"
  "port": 80
  "protocol": "HTTP"
  "hc_path": "/"
  "hc_protocol": "HTTP"
  "hc_matcher": "200-299"
  "hc_interval": 5
  "hc_timeout": 3
  "hc_ht": 2
  "hc_ut": 2
}

was_alb_tg = {
  "name": "was-alb-tg"
  "port": 8080
  "protocol": "HTTP"
  "hc_path": "/"
  "hc_protocol": "HTTP"
  "hc_matcher": "200-299"
  "hc_interval": 5
  "hc_timeout": 3
  "hc_ht": 2
  "hc_ut": 2
}

web_alb_rule = {
    "priority": 100
    "con_pp_values": ["*"]
    "act_type": "forward"
}

was_alb_rule = {
    "priority": 100
    "con_pp_values": ["*"]
    "act_type": "forward"
}