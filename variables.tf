# VPC---------------------------------

variable "region" {
  type    = string
}

variable "vpc" {
  type = object({
    vpc_name= string,
    cidr = string,
    eds = bool,
    edh = bool
  })
}

variable "web_subnet_1" {
  type = object({
    subnet_name= string,
    cidr = string,
    az = string,
    mpiol = bool
  })
}

variable "web_subnet_2" {
  type = object({
    subnet_name= string,
    cidr = string,
    az = string,
    mpiol = bool
  })
}

variable "was_subnet_1" {
  type = object({
    subnet_name= string,
    cidr = string,
    az = string
  })
}

variable "was_subnet_2" {
  type = object({
    subnet_name= string,
    cidr = string,
    az = string
  })
}

variable "db_subnet_1" {
  type = object({
    subnet_name= string,
    cidr = string,
    az = string
  })
}

variable "db_subnet_2" {
  type = object({
    subnet_name= string,
    cidr = string,
    az = string
  })
}

variable "igw_name" {
  type = string
}

variable "nat-gw-name" {
  description = "NAT Gateway name"
}

variable "public_rt_name" {
  type = string
}

variable "private_rt_name" {
  type = string
}

variable "db-subnet-grp-name" {
  type = string
}

# SG---------------------------------

variable "alb_web_sg" {
  type = object({
    name    = string
    description = string
  })
}

variable "alb_web_sg_inbound" {
  type = object({
    type    = string
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
  })
}

variable "alb_web_sg_outbound" {
  type = object({
    type    = string
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
  })
}

variable "alb_was_sg" {
  type = object({
    name    = string
    desc = string
    i_desc = string
    i_from_port = number
    i_to_port = number
    i_protocol = string
    e_from_port = number
    e_to_port = number
    e_protocol = string
    e_cidr = list(string)
  })
}

variable "db_sg" {
  type = object({
    name    = string
    desc = string
    i_from_port = number
    i_to_port = number
    i_protocol = string
    e_from_port = number
    e_to_port = number
    e_protocol = string
    e_cidr = list(string)
  })
}

variable "asg_web_sg" {
  type = object({
    name    = string
    desc = string
    i_desc = string
    i_from_port = number
    i_to_port = number
    i_protocol = string
    i2_desc = string
    i2_from_port = number
    i2_to_port = number
    i2_protocol = string
    i2_cidr = list(string)
    e_from_port = number
    e_to_port = number
    e_protocol = string
    e_cidr = list(string)
  })
}

variable "asg_was_sg" {
  type = object({
    name    = string
    desc = string
    i_desc = string
    i_from_port = number
    i_to_port = number
    i_protocol = string
    i2_desc = string
    i2_from_port = number
    i2_to_port = number
    i2_protocol = string
    e_from_port = number
    e_to_port = number
    e_protocol = string
    e_cidr = list(string)
  })
}

# ASG---------------------------------
variable "my_amazonlinux2" {
  type = object({
    most_recent = bool,
    fil_1_name = string,
    fil_1_values = list(string),
    fil_2_name = string,
    fil_2_values = list(string),
    owners = list(string)
  })
}

variable "web_launch_template" {
  type = object({
    name_prefix = string,
    instance_type = string,
    associate_public_ip_address = bool,
    create_before_destroy = bool
  })
}

variable "was_launch_template" {
  type = object({
    name_prefix = string,
    instance_type = string,
    create_before_destroy = bool
  })
}

variable "web_asg" {
  type = object({
    name = string,
    min_size = number,
    max_size = number,
    health_check_type = string,
    key = string,
    value = string,
    propagate_at_launch = bool
  })
}

variable "was_asg" {
  type = object({
    name = string,
    min_size = number,
    max_size = number,
    health_check_type = string,
    key = string,
    value = string,
    propagate_at_launch = bool
  })
}



# ALB---------------------------------

variable "web_alb" {
  type = object({
    name = string,
    lb_type = string
  })
}

variable "was_alb" {
  type = object({
    name = string,
    lb_type = string
  })
}

variable "web_alb_listener" {
  type = object({
    port = number,
    protocol = string,
    da_type = string,
    fr_ct_type = string,
    fr_ct_mb = string,
    fr_ct_sc = number
  })
}

variable "was_alb_listener" {
  type = object({
    port = number,
    protocol = string,
    da_type = string,
    fr_ct_type = string,
    fr_ct_mb = string,
    fr_ct_sc = number
  })
}

variable "web_alb_tg" {
  type = object({
    name = string,
    port = number,
    protocol = string,
    hc_path = string,
    hc_protocol = string,
    hc_matcher = string,
    hc_interval = number,
    hc_timeout = number,
    hc_ht = number,
    hc_ut = number
  })
}

variable "was_alb_tg" {
  type = object({
    name = string,
    port = number,
    protocol = string,
    hc_path = string,
    hc_protocol = string,
    hc_matcher = string,
    hc_interval = number,
    hc_timeout = number,
    hc_ht = number,
    hc_ut = number
  })
}

variable "web_alb_rule" {
  type = object({
    priority = number,
    con_pp_values = list(string),
    act_type = string
  })
}

variable "was_alb_rule" {
  type = object({
    priority = number,
    con_pp_values = list(string),
    act_type = string
  })
}
