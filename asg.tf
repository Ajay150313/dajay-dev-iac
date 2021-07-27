data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami*amazon-ecs-optimized"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon", "self"]
}

resource "aws_launch_configuration" "web-dev-lc" {
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  lifecycle {
    create_before_destroy = true
  }
  iam_instance_profile        = aws_iam_instance_profile.ecs_service_role.name
  key_name                    = "my-key"
  security_groups             = [aws_security_group.ec2-sg.id]
  associate_public_ip_address = true
  user_data                   = <<EOF
#! /bin/bash
sudo apt-get update
sudo echo "ECS_CLUSTER=${var.cluster_name}" >> /etc/ecs/ecs.config
sudo yum install -y httpd
sudo systemctl start httpd
EOF
}

resource "aws_autoscaling_group" "asg" {
  name                      = "web-app-asg"
  launch_configuration      = aws_launch_configuration.web-dev-lc.name
  min_size                  = 2
  max_size                  = 3
  desired_capacity          = 2
  health_check_type         = "ELB"
  health_check_grace_period = 300
  vpc_zone_identifier       = [aws_subnet.dajay-dev-public-subnet-1.id, aws_subnet.dajay-dev-public-subnet-2.id]

  target_group_arns     = [aws_lb_target_group.lb_target_group.arn]
  protect_from_scale_in = false
  lifecycle {
    create_before_destroy = true
  }
}