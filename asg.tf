data "aws_ami" "myamazonlinux2" {
  most_recent = var.my_amazonlinux2.most_recent
  filter {
    name   = var.my_amazonlinux2.fil_1_name
    values = var.my_amazonlinux2.fil_1_values
  }

  filter {
    name   = var.my_amazonlinux2.fil_2_name
    values = var.my_amazonlinux2.fil_2_values
  }

  owners = var.my_amazonlinux2.owners
}

resource "aws_launch_template" "web-launch-template" {
  name_prefix     = var.web_launch_template.name_prefix
  image_id        = data.aws_ami.myamazonlinux2.id
  instance_type   = var.web_launch_template.instance_type
  
  network_interfaces {
    security_groups = [aws_security_group.alb-web-sg.id]
    associate_public_ip_address = var.web_launch_template.associate_public_ip_address
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              wget https://busybox.net/downloads/binaries/1.31.0-defconfig-multiarch-musl/busybox-x86_64
              mv busybox-x86_64 busybox
              chmod +x busybox
              RZAZ=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone-id)
              IID=$(curl 169.254.169.254/latest/meta-data/instance-id)
              LIP=$(curl 169.254.169.254/latest/meta-data/local-ipv4)
              echo "<h1>RegionAz($RZAZ) : Instance ID($IID) : Private IP($LIP) : Web Server</h1>" > index.html
              nohup ./busybox httpd -f -p 80 &
              EOF
  )

  # Required when using a launch configuration with an auto scaling group.
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_template" "was-launch-template" {
  name_prefix     = var.was_launch_template.name_prefix
  image_id        = data.aws_ami.myamazonlinux2.id
  instance_type   = var.was_launch_template.instance_type
  
  network_interfaces {
    security_groups = [aws_security_group.alb-was-sg.id]
  }

  lifecycle {
    create_before_destroy = true
  }
}

# web autoscaling

resource "aws_autoscaling_group" "web-asg" {
  name                 = var.web_asg.name
  vpc_zone_identifier  = [aws_subnet.web-subnet1.id, aws_subnet.web-subnet2.id]
  min_size = var.web_asg.min_size
  max_size = var.web_asg.max_size
  health_check_type = var.web_asg.health_check_type
  target_group_arns = [aws_lb_target_group.web-alb-tg.arn]

  launch_template {
    id      = aws_launch_template.web-launch-template.id
    version = "$Latest"
  }

  tag {
    key                 = var.web_asg.key
    value               = var.web_asg.value
    propagate_at_launch = var.web_asg.propagate_at_launch
  }
}

# was autoscaling

resource "aws_autoscaling_group" "was-asg" {
  name                 = var.was_asg.name
  vpc_zone_identifier  = [aws_subnet.was-subnet1.id, aws_subnet.was-subnet2.id]
  min_size = var.was_asg.min_size
  max_size = var.was_asg.max_size
  health_check_type = var.was_asg.health_check_type
  target_group_arns = [aws_lb_target_group.was-alb-tg.arn]

  launch_template {
    id      = aws_launch_template.was-launch-template.id
    version = "$Latest"
  }

  tag {
    key                 = var.web_asg.key
    value               = var.web_asg.value
    propagate_at_launch = var.web_asg.propagate_at_launch
  }
} 

